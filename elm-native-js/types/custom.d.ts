export function withCustomElements(UIElement: any, handler: any): {
    new (): {
        [x: string]: any;
        wrapCallbackRefs: {};
        handler: any;
        data: any;
        attributeChangedCallback(name: any, _: any, newValue: any): void;
        connectedCallback(): void;
        disconnectedCallback(): void;
        addEventListener(event: any, callback: any): void;
        removeEventListener(event: any, callback: any): void;
        cloneAll(): any;
        manualRender(): void;
    };
    [x: string]: any;
    readonly observedAttributes: any;
};
