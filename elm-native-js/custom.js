export const withCustomElements = (UIElement, handler) =>
  class extends UIElement {
    constructor() {
      super()
      this.handler = handler
      this.data = this.handler.init()
    }
    static get observedAttributes() {
      return handler.observedAttributes
    }
    attributeChangedCallback(name, old, newValue) {
      this.handler.update(this.data, name, newValue)
      console.log(`${this.tagName} update`)

    }
    connectedCallback() {
      if (this.isConnected && this.handler.render) {
        this.handler.render(this, this.data)
      }
      console.log(`${this.tagName} connected`)
    }
    disconnectedCallback() {
      this.handler.dispose(this.data)
      console.log(`${this.tagName} disconnected`)
    }
    addEventListener(event, callback) {
      super.addEventListener(event, callback);
      this.handler.addEventListener(this.data, event, callback)
    }
    removeEventListener(event, callback) {
      super.removeEventListener(event, callback);
      this.handler.removeEventListener(this.data, event, callback);
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
