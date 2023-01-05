type global

type elmModule

type rec context = {
  window: Dom.window,
  document: Dom.document,
  initElements: context => unit,
  elm: unit => elmModule,
  flags: Js.Nullable.t<Obj.t>,
  initPorts: Js.Nullable.t<Obj.t => unit>,
  createFunctions: Obj.t => Obj.t,
  elements: array<Types.customElement>,
}

%%private(
  external global: global = "global"

  @set
  external setGlobalDocument: (global, Dom.document) => unit = "document"

  let getRootLayout: unit => NativescriptCore.rootLayout = _ =>
    %raw(`document.body.children[0].object`)

  let initElements = (params: context) => {
    let htmlElement = params.window->Mock.hTMLElement
    let customElements = params.window->Mock.customElements

    htmlElement->params.createFunctions->ignore

    params.elements->Belt.Array.forEach(element => {
      element.tagName->customElements.define(htmlElement->element.make)
    })

    NativescriptCore.Application.run({
      create: getRootLayout,
    })
  }
)

type config = {
  elmModule: unit => elmModule,
  elmModuleName: string,
  flags: Js.Nullable.t<Obj.t>,
  initPorts: Js.Nullable.t<Obj.t => unit>,
}

let start: config => unit = config => {
  let mockWindow = Mock.newWindow()
  mockWindow->Mock.patchInsertBefore

  let document = mockWindow->Mock.document
  global->setGlobalDocument(document)

  let context = {
    window: mockWindow,
    document,
    initElements,
    flags: config.flags,
    initPorts: config.initPorts,
    elm: config.elmModule,
    elements: Native.allElements,
    createFunctions: CustomElement.createFunctions,
  }

  let defineCustomElements = `initElements({window, createFunctions, elements})`
  let elmRoot = "elm-root"

  let elmInitScript = `
  const el = elm().${config.elmModuleName}.init({
    node: document.getElementById('${elmRoot}'),
    flags: flags
  })
  if(initPorts !== undefined || initPorts !== null)
    initPorts(el.ports)
   `

  let html = `<html><head><title>App</title></head><body><div id='${elmRoot}'></div></body></html>`

  document->Mock.writeString(html)

  Mock.runInContext(defineCustomElements, context)
  Mock.runInContext(elmInitScript, context)
}
