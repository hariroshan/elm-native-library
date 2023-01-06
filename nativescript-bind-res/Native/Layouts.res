module RootLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "RootLayout"
    let layout = new()
    let attributes = Helper.getPropsForObject(Obj.magic(layout))
    layout.destroyNode(.)
  )

  let tagName = "ns-root-layout"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: attributes,
    render: Js.Nullable.return((. current: Types.this, _) =>
      if !Js.Nullable.isNullable(current.parentElement.data.insertChild) {
        Types.requestAnimationFrame(._ => Helper.addView(. current.parentElement, current))
      }
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
    tagName: RootLayout.tagName,
    handler: RootLayout.handler,
  },
]
