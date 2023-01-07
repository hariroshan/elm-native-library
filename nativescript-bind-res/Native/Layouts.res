let render = Js.Nullable.return((. current: Types.this, _) => {
  let hasInsertChild =
    current.parentElement.data
    ->Js.Nullable.toOption
    ->Belt.Option.flatMap(x => x.insertChild->Js.Nullable.toOption)
    ->Belt.Option.isSome

  if hasInsertChild {
    Types.requestAnimationFrame(._ => Helper.addView(. current.parentElement, current))
  }
})

module AbsoluteLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "AbsoluteLayout"
  )

  let tagName = "ns-absolute-layout"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.layoutBase,
    render,
    pageAdded: Js.Nullable.null,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

module DockLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "DockLayout"
  )

  let tagName = "ns-dock-layout"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.dockLayout,
    render,
    pageAdded: Js.Nullable.null,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

module GridLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "GridLayout"
  )

  let tagName = "ns-grid-layout"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.layoutBase,
    render,
    pageAdded: Js.Nullable.null,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

module StackLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "StackLayout"
  )

  let tagName = "ns-stack-layout"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.stackLayout,
    render,
    pageAdded: Js.Nullable.null,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

module RootLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "RootLayout"
  )

  let tagName = "ns-root-layout"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.layoutBase,
    render,
    pageAdded: Js.Nullable.null,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

module WrapLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "WrapLayout"
  )

  let tagName = "ns-wrap-layout"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.wrapLayout,
    render,
    pageAdded: Js.Nullable.null,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

module FlexboxLayout = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "FlexboxLayout"
  )

  let tagName = "ns-flexbox-layout"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.flexboxLayout,
    render,
    pageAdded: Js.Nullable.null,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
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
