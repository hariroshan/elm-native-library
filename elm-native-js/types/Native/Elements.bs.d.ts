export var all: {
    tagName: string;
    handler: {
        init: () => any;
        observedAttributes: any;
        update: typeof NativescriptCore.update;
        render: any;
        handlerKind: number;
        dispose: typeof NativescriptCore.dispose;
        addEventListener: typeof NativescriptCore.addEventListener;
        removeEventListener: typeof NativescriptCore.removeEventListener;
    };
}[];
import * as NativescriptCore from "./NativescriptCore.bs.js";

export function buildHandler(newFunction: () => any, observedAttributes: string[], render) : void
