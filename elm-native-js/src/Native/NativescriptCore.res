type rootLayout

module AnimationCurve = {
  /* This function returns an object, but for simplicity we will say it returns string */
  type animationCurve = {cubicBezier: (. float, float, float, float) => string}

  %%private(
    let cubicBezierParamsRE = %re(`/cubicBezier\(([0-9]+\.?[0-9]*),([0-9]+\.?[0-9]*),([0-9]+\.?[0-9]*),([0-9]+\.?[0-9]*)\)/g`)

    let cubicBezierParams = value => {
      cubicBezierParamsRE
      ->Js.Re.exec_(value)
      ->Belt.Option.map(Js.Re.captures)
      ->Belt.Option.flatMap(captures => {
        let arr = captures->Js.Array2.sliceFrom(1)
        let (x1, y1) = (
          Belt.Array.get(arr, 0)->Belt.Option.flatMap(Js.Nullable.toOption),
          Belt.Array.get(arr, 1)->Belt.Option.flatMap(Js.Nullable.toOption),
        )
        let (x2, y2) = (
          Belt.Array.get(arr, 2)->Belt.Option.flatMap(Js.Nullable.toOption),
          Belt.Array.get(arr, 3)->Belt.Option.flatMap(Js.Nullable.toOption),
        )
        switch (x1, y1, x2, y2) {
        | (Some(a1), Some(b1), Some(a2), Some(b2)) => Some(((a1, b1), (a2, b2)))
        | _ => None
        }
      })
    }
    @module("@nativescript/core") @scope("CoreTypes")
    external animationCurve: animationCurve = "AnimationCurve"
  )

  let convertTransitionCurve = (transition: Types.transition<Types.raw>): Types.transition<
    Types.clean,
  > => {
    {
      ...transition,
      curve: switch transition.curve->Js.Nullable.toOption {
      | Some(curve) if !Js.String2.startsWith(curve, "cubicBezier") => Js.Nullable.return(curve)
      | Some(curve) =>
        curve
        ->cubicBezierParams
        ->Belt.Option.map((((x1, y1), (x2, y2))) => {
          animationCurve.cubicBezier(.
            Js.Float.fromString(x1),
            Js.Float.fromString(y1),
            Js.Float.fromString(x2),
            Js.Float.fromString(y2),
          )->Js.Nullable.return
        })
        ->Belt.Option.getWithDefault(Js.Nullable.return(curve))
      | None => Js.Nullable.null
      },
    }
  }
}

module Application = {
  type config = {create: unit => rootLayout}

  @module("@nativescript/core") @scope("Application")
  external run: config => unit = "run"
}

module Dialogs = {
  type alertOptions = {
    title: string,
    message: string,
    okButtonText: string,
    cancelable: bool,
  }

  type actionOptions = {
    title: string,
    message: string,
    cancelButtonText: string,
    actions: array<string>,
    cancelable: bool,
  }

  type confirmOptions = {
    title: string,
    message: string,
    okButtonText: string,
    cancelButtonText: string,
    neutralButtonText: string,
  }

  type loginOptions = {
    title: string,
    message: string,
    okButtonText: string,
    cancelButtonText: string,
    neutralButtonText: string,
    userNameHint: string,
    passwordHint: string,
    userName: string,
    password: string,
  }

  type promptOptions = {
    title: string,
    message: string,
    cancelButtonText: string,
    cancelable: bool,
    okButtonText: string,
    neutralButtonText: string,
    defaultText: string,
    inputType: string,
    capitalizationType: string,
  }

  @module("@nativescript/core") @scope("Dialogs")
  external alert: (. alertOptions) => Js.Promise.t<unit> = "alert"

  @module("@nativescript/core") @scope("Dialogs")
  external action: (. actionOptions) => Js.Promise.t<string> = "action"

  @module("@nativescript/core") @scope("Dialogs")
  external confirm: (. confirmOptions) => Js.Promise.t<bool> = "confirm"

  @module("@nativescript/core") @scope("Dialogs")
  external login: (. loginOptions) => Js.Promise.t<bool> = "login"

  @module("@nativescript/core") @scope("Dialogs")
  external prompt: (. promptOptions) => Js.Promise.t<bool> = "prompt"
}

%%private(
  let processAttrAndValue = (attr, value) => {
    if attr == "ios" || attr == "android" {
      let values = value->Js.String2.split(";")
      switch (values->Belt.Array.get(0), values->Belt.Array.get(1)) {
      | (Some(prop), Some(propVal)) => (
          Constants.camelCased(`${attr}.${prop}`),
          Types.makeAssignmentValue(propVal),
        )
      | _ => (Constants.camelCased(attr), Types.makeAssignmentValue(value))
      }
    } else {
      let (_, assignmentKind) as newValue = Types.makeAssignmentValue(value)
      let extracted =
        attr->Js.String2.split("bind-")->Belt.Array.get(1)->Belt.Option.getWithDefault(attr)

      (
        Constants.camelCased(extracted),
        // Allows expression binding only when attribute is prefixed.
        if assignmentKind == Types.BindingExpression {
          extracted != attr ? newValue : (value, Types.String)
          // Global Eval expression is skipped to prevent user from executing JS
        } else if attr == "text" && assignmentKind == Types.GlobalEvalExpression {
          (value, Types.String)
        } else {
          newValue
        },
      )
    }
  }
)

let rec update = (. nativeObject: Types.nativeObject, attr, newValue) => {
  let doesNotHaveIosAPI =
    attr->Js.String2.startsWith("ios") && Js.Nullable.isNullable(nativeObject.ios)
  let doesNotHaveAndroidAPI =
    attr->Js.String2.startsWith("android") && Js.Nullable.isNullable(nativeObject.android)
  if (Types.isIOS && doesNotHaveIosAPI) || (Types.isAndroid && doesNotHaveAndroidAPI) {
    Types.requestAnimationFrame(._ => update(. nativeObject, attr, newValue))
  } else {
    let (processedAttr, processedValue) = processAttrAndValue(attr, newValue)
    nativeObject->Obj.magic->Helper.update(processedAttr, processedValue)
  }
}

let dispose = (. nativeObject: Types.nativeObject) => {
  if (
    (Types.isIOS && !(nativeObject.ios->Js.Nullable.isNullable)) ||
      (Types.isAndroid && !(nativeObject.android->Js.Nullable.isNullable))
  ) {
    nativeObject.destroyNode(.)
  }
}

let addEventListener = (. nativeObject: Types.nativeObject, event, callback) => {
  nativeObject.on(. event, callback)
}
let removeEventListener = (. nativeObject: Types.nativeObject, event, callback) => {
  nativeObject.off(. event, callback)
}
