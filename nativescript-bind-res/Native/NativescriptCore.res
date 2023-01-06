type rootLayout

module Application = {
  type config = {create: unit => rootLayout}

  @module("@nativescript/core") @scope("Application")
  external run: config => unit = "run"
}

let update = (. nativeObject, attr, newValue) =>
  nativeObject->Obj.magic->Helper.update(attr, newValue)

let dispose = (. nativeObject: Types.nativeObject) => nativeObject.destroyNode(.)

let addEventListener = (. nativeObject: Types.nativeObject, event, callback) => {
  nativeObject.on(. event, callback)
}
let removeEventListener = (. nativeObject: Types.nativeObject, event, callback) => {
  nativeObject.off(. event, callback)
}
