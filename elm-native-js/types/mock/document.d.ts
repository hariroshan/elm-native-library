export default Document;
declare const Document_base: typeof import("happy-dom/lib/nodes/node/Node").default;
/**
 * Document.
 */
declare class Document extends Document_base {
    /**
     * Creates an instance of Document.
     *
     * @param defaultView Default view.
     */
    constructor(defaultView: any);
    onreadystatechange: any;
    nodeType: import("happy-dom/lib/nodes/node/NodeTypeEnum").default;
    adoptedStyleSheets: any[];
    children: import("happy-dom/lib/nodes/element/IHTMLCollection").default<import("happy-dom/lib/nodes/element/IElement").default>;
    readyState: import("happy-dom/lib/nodes/document/DocumentReadyStateEnum").default;
    isConnected: boolean;
    _activeElement: any;
    _isFirstWrite: boolean;
    _isFirstWriteAfterOpen: boolean;
    _cookie: string;
    _selection: any;
    defaultView: any;
    implementation: any;
    _readyStateManager: import("happy-dom/lib/nodes/document/DocumentReadyStateManager").default;
    /**
     * Returns character set.
     *
     * @deprecated
     * @returns Character set.
     */
    get charset(): any;
    /**
     * Returns character set.
     *
     * @returns Character set.
     */
    get characterSet(): any;
    /**
     * Last element child.
     *
     * @returns Element.
     */
    get childElementCount(): number;
    /**
     * First element child.
     *
     * @returns Element.
     */
    get firstElementChild(): import("happy-dom/lib/nodes/element/IElement").default;
    /**
     * Last element child.
     *
     * @returns Element.
     */
    get lastElementChild(): import("happy-dom/lib/nodes/element/IElement").default;
    /**
     * Sets a cookie string.
     *
     * @param cookie Cookie string.
     */
    set cookie(arg: string);
    /**
     * Returns cookie string.
     *
     * @returns Cookie.
     */
    get cookie(): string;
    /**
     * Returns <html> element.
     *
     * @returns Element.
     */
    get documentElement(): any;
    /**
     * Returns document type element.
     *
     * @returns Document type.
     */
    get doctype(): import("happy-dom/lib/nodes/document-type/DocumentType").default;
    /**
     * Returns <body> element.
     *
     * @returns Element.
     */
    get body(): any;
    /**
     * Returns <head> element.
     *
     * @returns Element.
     */
    get head(): any;
    /**
     * Returns CSS style sheets.
     *
     * @returns CSS style sheets.
     */
    get styleSheets(): any[];
    /**
     * Returns active element.
     *
     * @returns Active element.
     */
    get activeElement(): any;
    /**
     * Returns scrolling element.
     *
     * @returns Scrolling element.
     */
    get scrollingElement(): any;
    /**
     * Returns location.
     *
     * @returns Location.
     */
    get location(): any;
    /**
     * Returns scripts.
     *
     * @returns Scripts.
     */
    get scripts(): any;
    /**
     * Returns base URI.
     *
     * @override
     * @returns Base URI.
     */
    override get baseURI(): any;
    /**
     * Inserts a set of Node objects or DOMString objects after the last child of the ParentNode. DOMString objects are inserted as equivalent Text nodes.
     *
     * @param nodes List of Node or DOMString.
     */
    append(...nodes: any[]): void;
    /**
     * Inserts a set of Node objects or DOMString objects before the first child of the ParentNode. DOMString objects are inserted as equivalent Text nodes.
     *
     * @param nodes List of Node or DOMString.
     */
    prepend(...nodes: any[]): void;
    /**
     * Replaces the existing children of a node with a specified new set of children.
     *
     * @param nodes List of Node or DOMString.
     */
    replaceChildren(...nodes: any[]): void;
    /**
     * Query CSS selector to find matching elments.
     *
     * @param selector CSS selector.
     * @returns Matching elements.
     */
    querySelectorAll(selector: any): import("happy-dom/lib/nodes/node/INodeList").default<import("happy-dom/lib/nodes/element/IElement").default>;
    /**
     * Query CSS Selector to find a matching element.
     *
     * @param selector CSS selector.
     * @returns Matching element.
     */
    querySelector(selector: any): any;
    /**
     * Returns an elements by class name.
     *
     * @param className Tag name.
     * @returns Matching element.
     */
    getElementsByClassName(className: any): import("happy-dom/lib/nodes/element/IHTMLCollection").default<import("happy-dom/lib/nodes/element/IElement").default>;
    /**
     * Returns an elements by tag name.
     *
     * @param tagName Tag name.
     * @returns Matching element.
     */
    getElementsByTagName(tagName: any): any;
    /**
     * Returns an elements by tag name and namespace.
     *
     * @param namespaceURI Namespace URI.
     * @param tagName Tag name.
     * @returns Matching element.
     */
    getElementsByTagNameNS(namespaceURI: any, tagName: any): import("happy-dom/lib/nodes/element/IHTMLCollection").default<import("happy-dom/lib/nodes/element/IElement").default>;
    /**
     * Returns an element by ID.
     *
     * @param id ID.
     * @returns Matching element.
     */
    getElementById(id: any): any;
    /**
     * Returns an element by Name.
     *
     * @returns Matching element.
     * @param name
     */
    getElementsByName(name: any): import("happy-dom/lib/nodes/element/IHTMLCollection").default<import("happy-dom/lib/nodes/element/IElement").default>;
    /**
     * Append a child node to childNodes.
     *
     * @override
     * @param  node Node to append.
     * @returns Appended node.
     */
    override appendChild(node: any): import("happy-dom/lib/nodes/node/INode").default;
    /**
     * Remove Child element from childNodes array.
     *
     * @override
     * @param node Node to remove.
     */
    override removeChild(node: any): import("happy-dom/lib/nodes/node/INode").default;
    /**
     * Inserts a node before another.
     *
     * @override
     * @param newNode Node to insert.
     * @param [referenceNode] Node to insert before.
     * @returns Inserted node.
     */
    override insertBefore(newNode: any, referenceNode?: any): import("happy-dom/lib/nodes/node/INode").default;
    /**
     * Replaces the document HTML with new HTML.
     *
     * @param html HTML.
     */
    write(html: any): void;
    /**
     * Opens the document.
     *
     * @returns Document.
     */
    open(): Document;
    /**
     * Closes the document.
     */
    close(): void;
    /**
     * Creates an element.
     *
     * @param qualifiedName Tag name.
     * @param [options] Options.
     * @param [options.is] Tag name of a custom element previously defined via customElements.define().
     * @returns Element.
     */
    createElement(qualifiedName: any, options?: any): any;
    /**
     * Creates an element with the specified namespace URI and qualified name.
     *
     * @param namespaceURI Namespace URI.
     * @param qualifiedName Tag name.
     * @param [options] Options.
     * @param [options.is] Tag name of a custom element previously defined via customElements.define().
     * @returns Element.
     */
    createElementNS(namespaceURI: any, qualifiedName: any, options?: any): any;
    /**
     * Creates a text node.
     *
     * @param [data] Text data.
     * @returns Text node.
     */
    createTextNode(data?: any): import("happy-dom/lib/nodes/text/Text").default;
    /**
     * Creates a comment node.
     *
     * @param [data] Text data.
     * @returns Text node.
     */
    createComment(data?: any): import("happy-dom/lib/nodes/comment/Comment").default;
    /**
     * Creates a document fragment.
     *
     * @returns Document fragment.
     */
    createDocumentFragment(): import("happy-dom/lib/nodes/document-fragment/DocumentFragment").default;
    /**
     * Creates a Tree Walker.
     *
     * @param root Root.
     * @param [whatToShow] What to show.
     * @param [filter] Filter.
     */
    createTreeWalker(root: any, whatToShow?: number, filter?: any): import("happy-dom/lib/tree-walker/TreeWalker").default;
    /**
     * Creates an event.
     *
     * @deprecated
     * @param type Type.
     * @returns Event.
     */
    createEvent(type: any): any;
    /**
     * Creates an Attr node.
     *
     * @param name Name.
     * @returns Attribute.
     */
    createAttribute(name: any): import("happy-dom/lib/attribute/Attr").default;
    /**
     * Creates a namespaced Attr node.
     *
     * @param namespaceURI Namespace URI.
     * @param qualifiedName Qualified name.
     * @returns Element.
     */
    createAttributeNS(namespaceURI: any, qualifiedName: any): import("happy-dom/lib/attribute/Attr").default;
    /**
     * Imports a node.
     *
     * @param node Node to import.
     * @param [deep=false] Set to "true" if the clone should be deep.
     * @param Imported Node.
     */
    importNode(node: any, deep?: boolean): import("happy-dom/lib/nodes/node/INode").default;
    /**
     * Creates a range.
     *
     * @returns Range.
     */
    createRange(): any;
    /**
     * Adopts a node.
     *
     * @param node Node to adopt.
     * @returns Adopted node.
     */
    adoptNode(node: any): import("happy-dom/lib/nodes/node/INode").default | import("happy-dom/lib/nodes/node/Node").default;
    /**
     * Returns selection.
     *
     * @returns Selection.
     */
    getSelection(): any;
    /**
     * Returns a boolean value indicating whether the document or any element inside the document has focus.
     *
     * @returns "true" if the document has focus.
     */
    hasFocus(): boolean;
    /**
     * @override
     */
    override dispatchEvent(event: any): any;
    /**
     * Triggered by window when it is ready.
     */
    _onWindowReady(): void;
}
