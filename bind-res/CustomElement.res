type constructor = {
  observedAttributes: array<string>,
  name: string,
}

type event

type nativeObject = {
  on: (event, event => unit) => unit,
  off: (event, event => unit) => unit,
}

type super = {
  addEventListener: (event, event => unit) => unit,
  removeEventListener: (event, event => unit) => unit,
}

type extendedThis = {
  getAttributes: unit => Js.Dict.t<string>,
  getProps: unit => Js.Dict.t<string>,
  init: unit => unit,
  update: (string, string) => unit,
  dispose: unit => unit,
  isConnected: bool,
  render: Js.Nullable.t<unit => unit>,
  object: nativeObject,
}

type this = {
  getAttribute: string => Js.Nullable.t<string>,
  style: string,
  super: super,
  constructor: constructor,
}

%%private(
  @scope("prototype") @set
  external assignGetPropsInProto: (Obj.t, unit => Js.Dict.t<string>) => unit = "getProps"

  @scope("prototype") @set
  external assignGetAttributes: (Obj.t, unit => Js.Dict.t<string>) => unit = "getAttributes"

  @scope("prototype") @set
  external assignConstructor: (Obj.t, unit => unit) => unit = "constructor"

  @scope("prototype") @set
  external assignAttributeChangedCallback: (Obj.t, (string, unit, string) => unit) => unit =
    "attributeChangedCallback"

  @scope("prototype") @set
  external assignConnectedCallback: (Obj.t, unit => unit) => unit = "connectedCallback"

  @scope("prototype") @set
  external assignDisconnectedCallback: (Obj.t, unit => unit) => unit = "disconnectedCallback"

  @scope("prototype") @set
  external assignAddEventListener: (Obj.t, (event, event => unit) => unit) => unit =
    "addEventListener"

  @scope("prototype") @set
  external assignRemoveEventListener: (Obj.t, (event, event => unit) => unit) => unit =
    "removeEventListener"

  @set
  external assignObservedAttributes: (Obj.t, unit => array<string>) => unit = "observedAttributes"

  @val external this: this = "this"

  external toExtendedThis: this => extendedThis = "%identity"

  @val external thisSuper: unit => unit = "this.super"

  @set
  external setThisProps: (this, Js.Dict.t<string>) => unit = "props"

  let withAttrs = class => {
    class->assignObservedAttributes(_ => [])
    class->assignGetAttributes(_ => {
      this.constructor.observedAttributes->Belt.Array.reduce(Js.Dict.empty(), (acc, attrName) => {
        let attrValue = switch this.getAttribute(attrName)->Js.Nullable.toOption {
        | Some(a) => Some(a)
        | None => attrName == "style" ? Some(this.style) : None
        }
        let attrNameMap = attrName == "class" ? "className" : attrName

        attrValue
        ->Belt.Option.map(
          value => {
            acc->Js.Dict.set(attrNameMap, value)
            acc
          },
        )
        ->Belt.Option.getWithDefault(acc)
      })
    })
  }

  let withProps = class => {
    class->assignGetPropsInProto(() => {
      (this->toExtendedThis).getAttributes()
    })
  }

  let withCreate = class => {
    class->assignConstructor(() => {
      thisSuper()
      Js.log(this.constructor.name ++ " created")
      (this->toExtendedThis).init()
    })
  }

  let withInitAndUpdate = class => {
    class->assignAttributeChangedCallback((name, _, value) => {
      let extendedThis = this->toExtendedThis
      this->setThisProps(extendedThis.getProps())
      extendedThis.update(name, value)
      Js.log(this.constructor.name ++ " update")
    })
  }

  let withMountAndRender = class => {
    class->assignConnectedCallback(_ => {
      let extendedThis = this->toExtendedThis
      if extendedThis.isConnected {
        extendedThis.render->Js.Nullable.toOption->Belt.Option.forEach(fx => fx())
      }

      Js.log(this.constructor.name ++ " connected")
    })
  }

  let withUnmount = class => {
    class->assignDisconnectedCallback(_ => {
      (this->toExtendedThis).dispose()
      Js.log(this.constructor.name ++ " disconnected")
    })
  }

  let withEventListener = class => {
    class->assignAddEventListener((event, callback) => {
      this.super.addEventListener(event, callback)
      (this->toExtendedThis).object.on(event, callback)
    })
    class->assignRemoveEventListener((event, callback) => {
      this.super.removeEventListener(event, callback)
      (this->toExtendedThis).object.off(event, callback)
    })
  }
)

let createFunctions = class =>
  [
    withAttrs,
    withProps,
    withCreate,
    withInitAndUpdate,
    withMountAndRender,
    withUnmount,
    withEventListener,
  ]->Belt.Array.reduce(class, (acc, cur) => {
    cur(acc)
    acc
  })
