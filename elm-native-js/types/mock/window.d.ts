export class Window extends EventTarget_1.default {
    Node: typeof Node_1.default;
    CustomEvent: typeof CustomEvent_1.default;
    HTMLElement: typeof HTMLElement_1.default;
    customElements: CustomElementRegistry_1.default;
    document: Document;
}
export function patchInsertBefore(window: any): void;
import EventTarget_1 = require("../../node_modules/happy-dom/lib/event/EventTarget");
import Node_1 = require("../../node_modules/happy-dom/lib/nodes/node/Node");
import CustomEvent_1 = require("../../node_modules/happy-dom/lib/event/events/CustomEvent");
import HTMLElement_1 = require("../../node_modules/happy-dom/lib/nodes/html-element/HTMLElement");
import CustomElementRegistry_1 = require("../../node_modules/happy-dom/lib/custom-element/CustomElementRegistry");
import Document from "./document";
