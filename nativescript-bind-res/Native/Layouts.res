let render = Js.Nullable.return((. current: Types.htmlElement, _) => {
  // let hasInsertChild =
  //   current.parentElement.data
  //   ->Js.Nullable.toOption
  //   ->Belt.Option.flatMap(x => x.insertChild->Js.Nullable.toOption)
  //   ->Belt.Option.isSome

  // if hasInsertChild {
    Types.requestAnimationFrame(._ => Helper.addView(. current.parentElement, current))
  // }
})

let buildHandler: (unit => Types.nativeObject, array<string>) => Types.handler = (
  new,
  observedAttributes,
) => {
  init: (. ()) => new(),
  observedAttributes,
  render,
  handlerKind: Types.Layout,
  update: NativescriptCore.update,
  dispose: NativescriptCore.dispose,
  addEventListener: NativescriptCore.addEventListener,
  removeEventListener: NativescriptCore.removeEventListener,
}

module AbsoluteLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "AbsoluteLayout"
  )

  let tagName = "ns-absolute-layout"
  let handler: Types.handler = buildHandler(new, Constants.layoutBase)
}

module DockLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "DockLayout"
  )

  let tagName = "ns-dock-layout"
  let handler: Types.handler = buildHandler(new, Constants.dockLayout)
}

module GridLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "GridLayout"
  )

  let tagName = "ns-grid-layout"
  let handler: Types.handler = buildHandler(new, Constants.gridLayout)
}

module StackLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "StackLayout"
  )

  let tagName = "ns-stack-layout"
  let handler: Types.handler = buildHandler(new, Constants.stackLayout)
}

module RootLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "RootLayout"
  )

  let tagName = "ns-root-layout"
  let handler: Types.handler = buildHandler(new, Constants.layoutBase)
}

module WrapLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "WrapLayout"
  )

  let tagName = "ns-wrap-layout"
  let handler: Types.handler = buildHandler(new, Constants.wrapLayout)
}

module FlexboxLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "FlexboxLayout"
  )

  let tagName = "ns-flexbox-layout"
  let handler: Types.handler = buildHandler(new, Constants.flexboxLayout)
}

let all: array<Types.customElement> = [
  {
    tagName: AbsoluteLayout.tagName,
    handler: AbsoluteLayout.handler,
  },
  {
    tagName: DockLayout.tagName,
    handler: DockLayout.handler,
  },
  {
    tagName: FlexboxLayout.tagName,
    handler: FlexboxLayout.handler,
  },
  {
    tagName: GridLayout.tagName,
    handler: GridLayout.handler,
  },
  {
    tagName: RootLayout.tagName,
    handler: RootLayout.handler,
  },
  {
    tagName: StackLayout.tagName,
    handler: StackLayout.handler,
  },
  {
    tagName: WrapLayout.tagName,
    handler: WrapLayout.handler,
  },
]
