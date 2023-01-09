type event

type rec nativeObject = {
  on: (. event, event => unit) => unit,
  off: (. event, event => unit) => unit,
  destroyNode: (. unit) => unit,
  insertChild: Js.Nullable.t<(. nativeObject, int) => unit>,
}

type constructor = {
  observedAttributes: array<string>,
  name: string,
}

@val external requestAnimationFrame: (. unit => unit) => unit = "requestAnimationFrame"

@set
external setContent: (nativeObject, 'a) => unit = "content"

type navigationConfig = {create: unit => nativeObject}

@send
external navigate: (nativeObject, navigationConfig) => unit = "navigate"

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
