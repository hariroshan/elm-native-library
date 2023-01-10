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
    handlerKind: Types.Frame({
      pageAdded: (. current: Types.htmlElement) => {
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
      },
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
    let getData = (children, idx) =>
      children
      ->Belt.Array.get(idx)
      ->Belt.Option.flatMap((x: Types.htmlElement) => x.data->Js.Nullable.toOption)
  )

  let tagName = "ns-page"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.pageBase,
    update: NativescriptCore.update,
    render: Js.Nullable.return((. current: Types.htmlElement, nativeObject) => {
      Types.requestAnimationFrame(._ => {
        current.parentElement.handler
        ->Js.Nullable.toOption
        ->Belt.Option.forEach(
          handler =>
            switch handler.handlerKind {
            | Types.Frame({pageAdded}) => pageAdded(. current.parentElement)
            | _ => ()
            },
        )
      })
    }),
    handlerKind: Types.Page,
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
