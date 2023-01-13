const wrapCallback = (methods, callback) => e => {
  const custom = {}
  methods.forEach(method => {
    if(e[method] != null)
      custom[method] = e[method]()
  })
  e.custom = custom
  callback(e)
}

export const withCustomElements = (UIElement, handler) =>
  class extends UIElement {
    constructor() {
      super()
      this.wrapCallbackRefs = {}
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
      const indexOfSemiCol = event.indexOf(";")
      if (indexOfSemiCol !== -1) {
        const extractedEvent = event.substring(0, indexOfSemiCol)
        const wrappedCallback = wrapCallback(
          event.substring(indexOfSemiCol + 1).split(","),
          callback
        )
        super.addEventListener(extractedEvent, wrappedCallback);
        this.handler.addEventListener(this.data, extractedEvent, wrappedCallback)
        this.wrapCallbackRefs[callback] = wrappedCallback
      } else {
        super.addEventListener(event, callback);
        this.handler.addEventListener(this.data, event, callback)
      }
    }
    removeEventListener(event, callback) {
      const indexOfSemiCol = event.indexOf(";")
      if (indexOfSemiCol !== -1) {
        const extractedEvent = event.substring(0, indexOfSemiCol)
        const wrappedCallback = this.wrapCallbackRefs[callback]
        super.removeEventListener(extractedEvent, wrappedCallback);
        this.handler.removeEventListener(this.data, extractedEvent, wrappedCallback)

        delete this.wrapCallbackRefs[callback]
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
