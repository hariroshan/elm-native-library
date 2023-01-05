type global

type elmModule

type nativeInterface = {
  tagName: string,
  make: Obj.t => Obj.t,
}

type rec context = {
  window: Dom.window,
  initElements: context => unit,
  elm: unit => elmModule,
  createFunctions: Obj.t => Obj.t,
  elements: array<nativeInterface>,
}

%%private(
  external global: global = "global"

  @set
  external setGlobalDocument: (global, Dom.document) => unit = "document"

  @module("./Main.elm")
  external elmModule: unit => elmModule = "Elm"

  /* export default function ({ window, app }) {
  const { HTMLElement, customElements } = window
  const { mixins, elements } = app

  const mix = (klass, mixin) => mixin(klass)
  const UIElement = mixins.reduce(mix, HTMLElement)

  elements.forEach(rawElement => {
    const name = rawElement.tagName
    const element = rawElement.asElement(UIElement, window)
    customElements.define(name, element)
  })

  Application.run({
    create() {
      return document.body.children[0].object
    }
  })
} */

  let nativeElements: array<nativeInterface> = [
    {tagName: TextView.tagName, make: TextView.make},
    // {tagName: TextView.tagName, make: TextView.make},
  ]

  let initElements = (params: context) => {
    let htmlElement = params.window->Mock.hTMLElement
    let customElements = params.window->Mock.customElements

    htmlElement->params.createFunctions->ignore

    params.elements->Belt.Array.forEach(element => {
      element.tagName->customElements.define(htmlElement->element.make)
    })
  }
)

let start = _ => {
  let mockWindow = Mock.newWindow()
  mockWindow->Mock.patchInsertBefore

  let document = mockWindow->Mock.document
  global->setGlobalDocument(document)

  let context = {
    window: mockWindow,
    initElements,
    elm: elmModule,
    elements: nativeElements,
    createFunctions: CustomElement.createFunctions,
  }

  let defineCustomElements = `initElements({window, createFunctions, elements})`
  let elmRoot = "elm-root"

  let elmInitScript = `
  const el = elm().Main.init({
    node: document.getElementById('${elmRoot}')
  })
  console.log(el)
   `

  let html = `
     <html><head><title>App</title></head><body><div id='${elmRoot}'></div></body></html>
   `

  document->Mock.writeString(html)

  Mock.runInContext(defineCustomElements, context)
  Mock.runInContext(elmInitScript, context)
}
