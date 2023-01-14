type rootLayout

module Application = {
  type config = {create: unit => rootLayout}

  @module("@nativescript/core") @scope("Application")
  external run: config => unit = "run"
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
      (Constants.camelCased(attr), Types.makeAssignmentValue(value))
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

let dispose = (. nativeObject: Types.nativeObject) => nativeObject.destroyNode(.)

let addEventListener = (. nativeObject: Types.nativeObject, event, callback) => {
  nativeObject.on(. event, callback)
}
let removeEventListener = (. nativeObject: Types.nativeObject, event, callback) => {
  nativeObject.off(. event, callback)
}