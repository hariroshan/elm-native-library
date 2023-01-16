import { makeAssignmentValue, applyAssignmentKind, getKeyKind } from "./Native/Types.bs";
import { assignDeep } from "./Native/Helper.bs";
/*
function deepGetter(obj, i, keys) {
  if (keys.length == i) return obj == null ? null : obj
  if (obj == null) return null
  return deepGetter(obj[keys[i]], i + 1, keys)
}

function deepSetter(obj, keys, i, value) {
  if (keys.length - 1 == i) return obj[keys[i]] = value
  if (obj[keys[i]] == null) obj[keys[i]] = {}
  deepSetter(obj[keys[i]], keys, i + 1, value)
}
 */
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
      this.eventListners = {}
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
      this.data = null
      this.handler = null
      this.enhancedCallbackRefs = {}
      // console.log(`${this.tagName} disconnected`)
    }
    addEventListener(event, callback) {
      if (event.startsWith("{")) {
        const parsed = JSON.parse(event)
        const wrappedCallback = enhancedCallback(parsed, callback)
        super.addEventListener(parsed.event, wrappedCallback);
        this.handler.addEventListener(this.data, parsed.event, wrappedCallback)
        this.enhancedCallbackRefs[callback] = wrappedCallback
      } else {
        super.addEventListener(event, callback);
        this.handler.addEventListener(this.data, event, callback)
      }
      this.eventListners[event] = callback
    }
    removeEventListener(event, callback) {
      if (event.startsWith("{")) {
        const wrappedCallback = this.enhancedCallbackRefs[callback]
        const parsed = JSON.parse(event)
        super.removeEventListener(parsed.event, wrappedCallback);
        this.handler.removeEventListener(this.data, parsed.event, wrappedCallback)

        delete this.enhancedCallbackRefs[callback]
      } else {
        super.removeEventListener(event, callback);
        this.handler.removeEventListener(this.data, event, callback);
      }
      delete this.eventListners[event]
    }
    cloneAll() {
      const tag = document.createElement(this.tagName)
      const children =
        Array.from(this.children).forEach(child => tag.appendChild(child.cloneAll()))

      // Copy attributes
      Object.keys(this.attributes).forEach(key => {
        const attr = this.attributes[key]
        if (attr && attr.name !== undefined && attr.value !== undefined) {
          tag.setAttribute(attr.name, attr.value)
        }
      })

      // Setup event listeners
      Object.entries(this.eventListners).forEach(entry => {
        tag.addEventListener(entry[0], entry[1])
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
