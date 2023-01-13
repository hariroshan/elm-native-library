export var all: {
    tagName: string;
    handler: {
        init: () => any;
        observedAttributes: any;
        update: typeof NativescriptCore.update;
        render: typeof render;
        handlerKind: number;
        dispose: typeof NativescriptCore.dispose;
        addEventListener: typeof NativescriptCore.addEventListener;
        removeEventListener: typeof NativescriptCore.removeEventListener;
    };
}[];
import * as NativescriptCore from "./NativescriptCore.bs.js";
declare function render(current: any, param: any): void;
export {};
