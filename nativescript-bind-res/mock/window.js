import Document from "./document";
import Node_1 from "happy-dom/lib/nodes/node/Node";
import CustomEvent_1 from "happy-dom/lib/event/events/CustomEvent";
import HTMLElement_1 from "happy-dom/lib/nodes/html-element/HTMLElement";
import CustomElementRegistry_1 from "happy-dom/lib/custom-element/CustomElementRegistry";
import EventTarget_1 from "happy-dom/lib/event/EventTarget";

export class Window extends EventTarget_1 {
  constructor() {
    super();
    this.Node = Node_1;
    this.CustomEvent = CustomEvent_1;
    this.HTMLElement = HTMLElement_1;
    this.customElements = new CustomElementRegistry_1();
    const document = new Document(this)
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
