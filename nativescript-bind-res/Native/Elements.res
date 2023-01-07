module Label = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Label"
  )
  let tagName = "ns-label"

  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.textBase,
    render: Js.Nullable.return((. current: Types.this, _) =>
      Helper.addView(. current.parentElement, current)
    ),
    pageAdded: Js.Nullable.null,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

module Button = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Button"
  )
  let tagName = "ns-button"

  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.button,
    render: Js.Nullable.return((. current: Types.this, _) =>
      Helper.addView(. current.parentElement, current)
    ),
    pageAdded: Js.Nullable.null,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

let all: array<Types.customElement> = [
  {
    tagName: Label.tagName,
    handler: Label.handler,
  },
  {
    tagName: Button.tagName,
    handler: Button.handler,
  },
]
