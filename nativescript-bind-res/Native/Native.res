module Frame = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Frame"
    let frame = new()
    let attributes = Helper.getPropsForObject(Obj.magic(frame))
    frame.destroyNode(.)
  )
  let tagName = "ns-frame"

  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: attributes,
    update: NativescriptCore.update,
    render: Js.Nullable.null,
    pageAdded: Js.Nullable.return((. current: Types.this) => {
      current.data->Types.navigate({
        create: _ =>
          (current.children->Array.unsafe_get(current.children->Array.length - 1)).data,
      })
    }),
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

module Page = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Page"
    let page = new()
    let attributes = Helper.getPropsForObject(Obj.magic(page))
    page.destroyNode(.)
  )

  let tagName = "ns-page"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: attributes,
    update: NativescriptCore.update,
    render: Js.Nullable.return((. current: Types.this, nativeObject) => {
      // page should have one child which is a layout
      nativeObject->Types.setContent((current.children->Array.unsafe_get(0)).data)

      Types.requestAnimationFrame(._ => {
        current.parentElement.handler.pageAdded
        ->Js.Nullable.toOption
        ->Belt.Option.forEach(fx => fx(. current.parentElement))
      })
    }),
    pageAdded: Js.Nullable.null,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

let allElements: array<Types.customElement> = Belt.Array.concatMany([
  Elements.all,
  Layouts.all,
  [
    {tagName: Page.tagName, handler: Page.handler},
    {tagName: Frame.tagName, handler: Frame.handler},
  ],
])
