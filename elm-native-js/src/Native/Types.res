type event
type constructorRec = {name: string}
type bindingOptions = {expression: string, targetProperty: string}
type iosAPI
type androidAPI

type rec nativeObject = {
  on: (. event, event => unit) => unit,
  off: (. event, event => unit) => unit,
  destroyNode: (. unit) => unit,
  insertChild: Js.Nullable.t<(. nativeObject, int) => unit>,
  items: array<string>,
  constructor: constructorRec,
  ios: Js.Nullable.t<iosAPI>,
  android: Js.Nullable.t<androidAPI>,
}

type constructor = {
  observedAttributes: array<string>,
  name: string,
}

type transition = {
  /**
	 * Can be one of the built-in transitions:
	 * - curl (same as curlUp) (iOS only)
	 * - curlUp (iOS only)
	 * - curlDown (iOS only)
	 * - explode (Android Lollipop(21) and up only)
	 * - fade
	 * - flip (same as flipRight)
	 * - flipRight
	 * - flipLeft
	 * - slide (same as slideLeft)
	 * - slideLeft
	 * - slideRight
	 * - slideTop
	 * - slideBottom
	 */
  name: Js.Nullable.t<string>,
  duration: Js.Nullable.t<int>,
  /* ease, easeIn, easeInOut, easeOut, linear, spring */
  curve: Js.Nullable.t<string>,
}

type navigationOptions = {
  animated: Js.Nullable.t<bool>,
  transition: Js.Nullable.t<transition>,
  transitioniOS: Js.Nullable.t<transition>,
  transitionAndroid: Js.Nullable.t<transition>,
  backstackVisible: Js.Nullable.t<bool>,
  clearHistory: Js.Nullable.t<bool>,
}

@val external requestAnimationFrame: (. unit => unit) => unit = "requestAnimationFrame"

@set
external setContent: (nativeObject, 'a) => unit = "content"

@set
external setItems: (nativeObject, 'a) => unit = "items"

@set
external setView: (nativeObject, 'a) => unit = "view"

type navigationConfig = {create: unit => nativeObject}

@send
external navigate: (nativeObject, navigationConfig) => unit = "navigate"

@send
external bindExpression: (Obj.t, bindingOptions) => unit = "bind"

@send
external refresh: nativeObject => unit = "refresh"

@val
external eval: string => 'a = "eval"

@module("@nativescript/core") @val external isIOS: bool = "isIOS"

@module("@nativescript/core") @val external isAndroid: bool = "isAndroid"

type rec handler = {
  init: (. unit) => nativeObject,
  observedAttributes: array<string>,
  update: (. nativeObject, string, string) => unit,
  render: Js.Nullable.t<(. htmlElement, nativeObject) => unit>,
  handlerKind: handlerKind,
  dispose: (. nativeObject) => unit,
  addEventListener: (. nativeObject, event, event => unit) => unit,
  removeEventListener: (. nativeObject, event, event => unit) => unit,
}
and htmlElement = {
  getAttribute: string => Js.Nullable.t<string>,
  style: string,
  constructor: constructor,
  parentElement: htmlElement,
  handler: Js.Nullable.t<handler>,
  data: Js.Nullable.t<nativeObject>,
  children: array<htmlElement>,
  items: array<string>,
  navigationOptions: Js.Nullable.t<navigationOptions>,
}
and frameMethods = {pageAdded: (. htmlElement) => unit}
and handlerKind =
  | Frame(frameMethods)
  | Page
  | Layout
  | Element

type customElement = {
  tagName: string,
  handler: handler,
}

type setter<'a> = {set: 'a => unit}

@scope("Object") @val
external definePropertyInHtml: (. htmlElement, string, setter<'a>) => unit = "defineProperty"

type assignmentKind =
  | String
  | GlobalEvalExpression
  | BindingExpression

type assignmentValue = (string, assignmentKind)

%%private(
  let bindingExpressionRe = %re(`/^b{(.*)}$/`)
  let globalEvalExpressionRe = %re("/^e{(.*)}$/")

  let executeReAndGetResult = (value, re, kind) => {
    value
    ->Js.String2.match_(re)
    ->Belt.Option.flatMap(bindingResult => bindingResult->Belt.Array.get(1))
    ->Belt.Option.flatMap(x => x)
    ->Belt.Option.map(x => (x->Js.String2.replace("&#x27;", "'"), kind))
  }
)

let makeAssignmentValue: string => assignmentValue = value => {
  value
  ->executeReAndGetResult(bindingExpressionRe, BindingExpression)
  ->Belt.Option.orElse(value->executeReAndGetResult(globalEvalExpressionRe, GlobalEvalExpression))
  ->Belt.Option.getWithDefault((value, String))
}

let getKeyKind = key => {
  if key->Js.String2.startsWith("ios") {
    Some("ios")
  } else if key->Js.String2.startsWith("android") {
    Some("android")
  } else {
    None
  }
}

let applyAssignmentKind: (option<string>, assignmentValue) => 'a = (keyKind, (value, kind)) => {
  switch kind {
  | String => value
  | GlobalEvalExpression =>
    switch keyKind {
    | None => eval(value)
    | Some("ios") if isIOS => eval(value)
    | Some("android") if isAndroid => eval(value)
    | _ => value
    }

  | BindingExpression => value
  }
}
