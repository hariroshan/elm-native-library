import { makeAssignmentValue, applyAssignmentKind, getKeyKind } from "./Native/Types.bs";
import { assignDeep } from "./Native/Helper.bs";

const enhancedCallback = (parsed, callback) => e => {
  // console.log(parsed)
  parsed.setters.forEach(setter => {
    assignDeep(e, setter.keys, 0,
      applyAssignmentKind(
        getKeyKind(setter.keys[0]),
        makeAssignmentValue(setter.value))
    )
  })

  const custom = {}
  parsed.methods.forEach(method => {
    if (e[method] != null)
      custom[method] = e[method]()
  })
  e.custom = custom
  callback(e)
}

export const withCustomElements = (UIElement, handler) =>
  class extends UIElement {
    constructor() {
      super()
      this.enhancedCallbackRefs = {}
      this.handler = handler
      this.data = this.handler.init()
    }
    static get observedAttributes() {
      return handler.observedAttributes
    }
    attributeChangedCallback(name, _, newValue) {
      this.handler.update(this.data, name, newValue)
      // console.log(`${this.tagName} update`)
    }
    connectedCallback() {
      if (this.isConnected && this.handler.render) {
        this.handler.render(this, this.data)
      }
      // console.log(`${this.tagName} connected`)
    }
    disconnectedCallback() {
      this.handler.dispose(this.data)
      // console.log(`${this.tagName} disconnected`)
    }
    addEventListener(event, callback) {
      if (event.startsWith("{")) {
        const parsed = JSON.parse(event)
        const wrappedCallback = enhancedCallback(
          parsed,
          callback
        )
        super.addEventListener(parsed.event, wrappedCallback);
        this.handler.addEventListener(this.data, parsed.event, wrappedCallback)
        this.enhancedCallbackRefs[callback] = wrappedCallback
      } else {
        super.addEventListener(event, callback);
        this.handler.addEventListener(this.data, event, callback)
      }
    }
    removeEventListener(event, callback) {
      if (event.startsWith("{")) {
        const parsed = JSON.parse(event)
        const wrappedCallback = this.enhancedCallbackRefs[callback]
        super.removeEventListener(parsed.event, wrappedCallback);
        this.handler.removeEventListener(this.data, parsed.event, wrappedCallback)

        delete this.enhancedCallbackRefs[callback]
      } else {
        super.removeEventListener(event, callback);
        this.handler.removeEventListener(this.data, event, callback);
      }
    }
    cloneAll() {
      const tag = document.createElement(this.tagName)
      const children =
        Array.from(this.children).forEach(child => tag.appendChild(child.cloneAll()))

      Object.keys(this.attributes).forEach(key => {
        const attr = this.attributes[key]
        if (attr && attr.name !== undefined && attr.value !== undefined) {
          tag.setAttribute(attr.name, attr.value)
        }
      })
      return tag
    }

    manualRender() {
      Array.from(this.children).forEach(child =>
        child.manualRender()
      )
      this.handler.render(this, this.data)
    }
  }
