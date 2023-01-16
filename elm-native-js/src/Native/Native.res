module Frame = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Frame"
    let setNullableProperty = (
      current: Types.htmlElement,
      config: Types.navigationConfig,
      key: string,
      fx: Types.navigationOptions => Js.Nullable.t<'a>,
    ) =>
      current.navigationOptions
      ->Js.Nullable.toOption
      ->Belt.Option.flatMap(x => fx(x)->Js.Nullable.toOption)
      ->Belt.Option.forEach(value => {
        config->Obj.magic->Js.Dict.set(key, value)
      })
    let modalEv: ref<option<Types.event>> = ref(None)
  )
  let tagName = "ns-frame"

  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.frameBase,
    update: NativescriptCore.update,
    render: Js.Nullable.return((. current: Types.htmlElement, data: Types.nativeObject) => {
      Types.definePropertyInHtml(.
        current,
        "popStack",
        {
          set: value => {
            if value {
              switch modalEv.contents {
              | None => data->Types.goBack
              | Some(ev) =>
                ev.closeCallback()
                modalEv := None
              }
            }
          },
        },
      )
    }),
    handlerKind: Types.Frame({
      pageAdded: (. current: Types.htmlElement) => {
        current.data
        ->Js.Nullable.toOption
        ->Belt.Option.forEach(data => {
          let pageElement = current.children->Belt.Array.get(current.children->Array.length - 1)
          let pageData =
            pageElement
            ->Belt.Option.flatMap(x => x.data->Js.Nullable.toOption)
            ->Belt.Option.getWithDefault(data)

          switch pageElement->Belt.Option.flatMap(x => Js.Nullable.toOption(x.modalPage)) {
          | Some(fullscreen) =>
            let callback = ev => {
              modalEv := Some(ev)
            }
            data->Types.showModal(
              pageData,
              {
                fullscreen,
                closeCallback: _ => {
                  pageData.off(. "shownModally", callback)
                },
              },
            )
            pageData.on(. "shownModally", callback)
          | None =>
            let config: Types.navigationConfig = {
              create: _ => pageData,
            }
            current->setNullableProperty(config, "animated", (x: Types.navigationOptions) =>
              x.animated
            )
            current->setNullableProperty(config, "transition", (x: Types.navigationOptions) =>
              x.transition
            )
            current->setNullableProperty(config, "transitioniOS", (x: Types.navigationOptions) =>
              x.transitioniOS
            )
            current->setNullableProperty(config, "transitionAndroid", (
              x: Types.navigationOptions,
            ) => x.transitionAndroid)
            current->setNullableProperty(config, "backstackVisible", (x: Types.navigationOptions) =>
              x.backstackVisible
            )
            current->setNullableProperty(config, "clearHistory", (x: Types.navigationOptions) =>
              x.clearHistory
            )
            data->Types.navigate(config)
          }
        })
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
  )

  let tagName = "ns-page"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.pageBase,
    update: NativescriptCore.update,
    render: Js.Nullable.return((. current: Types.htmlElement, _) => {
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
