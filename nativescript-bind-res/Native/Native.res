module Frame = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Frame"
  )
  let tagName = "ns-frame"

  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.frameBase,
    update: NativescriptCore.update,
    render: Js.Nullable.null,
    pageAdded: Js.Nullable.return((. current: Types.this) => {
      current.data
      ->Js.Nullable.toOption
      ->Belt.Option.forEach(data =>
        data->Types.navigate({
          create: _ =>
            current.children
            ->Belt.Array.get(current.children->Array.length - 1)
            ->Belt.Option.flatMap(x => x.data->Js.Nullable.toOption)
            ->Belt.Option.getWithDefault(data),
        })
      )
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
  )

  let tagName = "ns-page"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.pageBase,
    update: NativescriptCore.update,
    render: Js.Nullable.return((. current: Types.this, nativeObject) => {
      // page should have one child which is a layout
      current.children
      ->Belt.Array.get(0)
      ->Belt.Option.flatMap(x => x.data->Js.Nullable.toOption)
      ->Belt.Option.forEach(data => nativeObject->Types.setContent(data))

      Types.requestAnimationFrame(._ => {
        current.parentElement.handler
        ->Js.Nullable.toOption
        ->Belt.Option.flatMap(handler => handler.pageAdded->Js.Nullable.toOption)
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
