type global

type elmModule

type rec context = {
  window: Dom.window,
  document: Dom.document,
  initElements: context => unit,
  elm: unit => elmModule,
  flags: Js.Nullable.t<Obj.t>,
  isIOS: bool,
  isAndroid: bool,
  taskportInit: unit => unit,
  initPorts: Js.Nullable.t<Obj.t => unit>,
  customElements: Js.Nullable.t<array<Types.customElement>>,
  extendCustomElements: Js.Nullable.t<(. string, Obj.t) => Obj.t>,
  withCustomElements: (. Obj.t, Types.handler) => Obj.t,
  elements: array<Types.customElement>,
  run: unit => unit,
}

%%private(
  external global: global = "global"

  @set
  external setGlobalDocument: (global, Dom.document) => unit = "document"

  @set
  external setGlobalWindow: (global, Dom.window) => unit = "window"

  let getRootLayout: unit => NativescriptCore.rootLayout = _ =>
    %raw(`document.body.children[0].data`)

  let initElements = (params: context) => {
    let htmlElement = params.window->Mock.hTMLElement
    let customElements = params.window->Mock.customElements
    let defineElements = (element: Types.customElement) => {
      let newClass = params.withCustomElements(. htmlElement, element.handler)
      let extendedClass =
        params.extendCustomElements
        ->Js.Nullable.toOption
        ->Belt.Option.mapWithDefault(newClass, (fx: (. string, Obj.t) => Obj.t) =>
          fx(. element.tagName, newClass)
        )

      customElements.define(. element.tagName, extendedClass)
    }
    params.elements->Belt.Array.forEach(defineElements)
    params.customElements
    ->Js.Nullable.toOption
    ->Belt.Option.forEach((customElementsArray: array<Types.customElement>) => {
      customElementsArray->Belt.Array.forEach(defineElements)
    })
  }
)

type config = {
  elmModule: unit => elmModule,
  elmModuleName: string,
  flags: Js.Nullable.t<Obj.t>,
  initPorts: Js.Nullable.t<Obj.t => unit>,
  customElements: Js.Nullable.t<array<Types.customElement>>,
  extendCustomElements: Js.Nullable.t<(. string, Obj.t) => Obj.t>,
}

let start: config => unit = config => {
  let mockWindow = Mock.newWindow()
  mockWindow->Mock.patchInsertBefore

  let document = mockWindow->Mock.document
  global->setGlobalDocument(document)
  global->setGlobalWindow(mockWindow)

  let context = {
    window: mockWindow,
    document,
    initElements,
    flags: config.flags,
    initPorts: config.initPorts,
    customElements: config.customElements,
    extendCustomElements: config.extendCustomElements,
    isIOS: Types.isIOS,
    isAndroid: Types.isAndroid,
    elm: config.elmModule,
    elements: Native.allElements,
    taskportInit: Taskport.register,
    withCustomElements: CustomElement.withCustomElements,
    run: () =>
      NativescriptCore.Application.run({
        create: getRootLayout,
      }),
  }

  let defineCustomElements = `initElements({window, withCustomElements, elements, extendCustomElements, customElements})`
  let elmRoot = "elm-root"

  let elmInitScript = `
  taskportInit()
  const el = elm().${config.elmModuleName}.init({
    node: document.getElementById('${elmRoot}'),
    flags: flags
  })
  if(el != null && initPorts != null) initPorts(el.ports)
   `

  let html = `<html><head><title>App</title></head><body><div id='${elmRoot}'></div></body></html>`

  document->Mock.writeString(html)

  Mock.runInContext(defineCustomElements, context)
  Mock.runInContext(elmInitScript, context)
  Mock.runInContext(`run()`, context)
}
