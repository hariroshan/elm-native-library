import Document from "./document";
const Node_1 = require("../../node_modules/happy-dom/lib/nodes/node/Node");
const CustomEvent_1 = require("../../node_modules/happy-dom/lib/event/events/CustomEvent");
const HTMLElement_1 = require("../../node_modules/happy-dom/lib/nodes/html-element/HTMLElement");
const CustomElementRegistry_1 = require("../../node_modules/happy-dom/lib/custom-element/CustomElementRegistry");
const EventTarget_1 = require("../../node_modules/happy-dom/lib/event/EventTarget");

export class Window extends EventTarget_1.default {
  constructor() {
    super();
    this.Node = Node_1.default;
    this.CustomEvent = CustomEvent_1.default;
    this.HTMLElement = HTMLElement_1.default;
    this.customElements = new CustomElementRegistry_1.default();
    const document =  new Document(this)
    this.document = document;
  }
}

export const patchInsertBefore = (window) => {
  /**
   * Patch `insertBefore` function to default reference node to null when passed undefined.
   * This is technically only needed for an Elm issue in version 1.0.2 of the VirtualDom
   * More context here: https://github.com/elm/virtual-dom/issues/161
   * And here: https://github.com/elm/virtual-dom/blob/1.0.2/src/Elm/Kernel/VirtualDom.js#L1409
  */

  const insertBefore = window.Node.prototype.insertBefore
  window.Node.prototype.insertBefore = function (...args) {
    const [newNode, refNode] = args
    const hasRefNode = args.length > 1
    const isRefNodeDefined = typeof refNode !== 'undefined'
    if (hasRefNode && !isRefNodeDefined)
      return insertBefore.call(this, newNode, null)
    return insertBefore.call(this, ...args)
  }
}
