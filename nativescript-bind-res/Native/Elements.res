module Label = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Label"
    let label = new()
    let attributes = Helper.getPropsForObject(Obj.magic(label))
    label.destroyNode(.)
  )
  let tagName = "ns-label"

  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: attributes,
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
]
