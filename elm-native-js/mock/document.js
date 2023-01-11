"use strict";
const Element_1 = (require("../../node_modules/happy-dom/lib/nodes/element/Element"));
const HTMLUnknownElement_1 = (require("../../node_modules/happy-dom/lib/nodes/html-unknown-element/HTMLUnknownElement"));
const Text_1 = (require("../../node_modules/happy-dom/lib/nodes/text/Text"));
const Comment_1 = (require("../../node_modules/happy-dom/lib/nodes/comment/Comment"));
const Node_1 = (require("../../node_modules/happy-dom/lib/nodes/node/Node"));
const TreeWalker_1 = (require("../../node_modules/happy-dom/lib/tree-walker/TreeWalker"));
const DocumentFragment_1 = (require("../../node_modules/happy-dom/lib/nodes/document-fragment/DocumentFragment"));
const XMLParser_1 = (require("../../node_modules/happy-dom/lib/xml-parser/XMLParser"));
const Event_1 = (require("../../node_modules/happy-dom/lib/event/Event"));
const DOMImplementation_1 = (require("../../node_modules/happy-dom/lib/dom-implementation/DOMImplementation"));

// const ElementTag_1 = (require("../../node_modules/happy-dom/lib/config/ElementTag"));

const Attr_1 = (require("../../node_modules/happy-dom/lib/attribute/Attr"));
const NamespaceURI_1 = (require("../../node_modules/happy-dom/lib/config/NamespaceURI"));
const DocumentType_1 = (require("../../node_modules/happy-dom/lib/nodes/document-type/DocumentType"));
const ParentNodeUtility_1 = (require("../../node_modules/happy-dom/lib/nodes/parent-node/ParentNodeUtility"));
const QuerySelector_1 = (require("../../node_modules/happy-dom/lib/query-selector/QuerySelector"));
const DOMException_1 = (require("../../node_modules/happy-dom/lib/exception/DOMException"));
const HTMLCollectionFactory_1 = (require("../../node_modules/happy-dom/lib/nodes/element/HTMLCollectionFactory"));
const DocumentReadyStateEnum_1 = (require("../../node_modules/happy-dom/lib/nodes/document/DocumentReadyStateEnum"));
const DocumentReadyStateManager_1 = (require("../../node_modules/happy-dom/lib/nodes/document/DocumentReadyStateManager"));
const Selection_1 = (require("../../node_modules/happy-dom/lib/selection/Selection"));
/**
 * Document.
 */
 class Document extends Node_1.default {
  /**
   * Creates an instance of Document.
   *
   * @param defaultView Default view.
   */
  constructor(defaultView) {
      super();
      this.onreadystatechange = null;
      this.nodeType = Node_1.default.DOCUMENT_NODE;
      this.adoptedStyleSheets = [];
      this.children = HTMLCollectionFactory_1.default.create();
      this.readyState = DocumentReadyStateEnum_1.default.interactive;
      this.isConnected = true;
      this._activeElement = null;
      this._isFirstWrite = true;
      this._isFirstWriteAfterOpen = false;
      this._cookie = '';
      this._selection = null;
      this.defaultView = defaultView //this.constructor._defaultView;
      this.implementation = new DOMImplementation_1.default(this);
      this._readyStateManager = new DocumentReadyStateManager_1.default(this.defaultView);
      const doctype = this.implementation.createDocumentType('html', '', '');
      const documentElement = this.createElement('html');
      const bodyElement = this.createElement('body');
      const headElement = this.createElement('head');
      this.appendChild(doctype);
      this.appendChild(documentElement);
      documentElement.appendChild(headElement);
      documentElement.appendChild(bodyElement);
  }
  /**
   * Returns character set.
   *
   * @deprecated
   * @returns Character set.
   */
  get charset() {
      return this.characterSet;
  }
  /**
   * Returns character set.
   *
   * @returns Character set.
   */
  get characterSet() {
      const charset = this.querySelector('meta[charset]')?.getAttributeNS(null, 'charset');
      return charset ? charset : 'UTF-8';
  }
  /**
   * Last element child.
   *
   * @returns Element.
   */
  get childElementCount() {
      return this.children.length;
  }
  /**
   * First element child.
   *
   * @returns Element.
   */
  get firstElementChild() {
      return this.children ? this.children[0] || null : null;
  }
  /**
   * Last element child.
   *
   * @returns Element.
   */
  get lastElementChild() {
      return this.children ? this.children[this.children.length - 1] || null : null;
  }
  /**
   * Returns cookie string.
   *
   * @returns Cookie.
   */
  get cookie() {
      return this._cookie;
  }
  /**
   * Sets a cookie string.
   *
   * @param cookie Cookie string.
   */
  set cookie(cookie) {
      this._cookie = CookieUtility_1.default.getCookieString(this.defaultView.location, this._cookie, cookie);
  }
  /**
   * Node name.
   *
   * @returns Node name.
   */
  get nodeName() {
      return '#document';
  }
  /**
   * Returns <html> element.
   *
   * @returns Element.
   */
  get documentElement() {
      return ParentNodeUtility_1.default.getElementByTagName(this, 'html');
  }
  /**
   * Returns document type element.
   *
   * @returns Document type.
   */
  get doctype() {
      for (const node of this.childNodes) {
          if (node instanceof DocumentType_1.default) {
              return node;
          }
      }
      return null;
  }
  /**
   * Returns <body> element.
   *
   * @returns Element.
   */
  get body() {
      return ParentNodeUtility_1.default.getElementByTagName(this, 'body');
  }
  /**
   * Returns <head> element.
   *
   * @returns Element.
   */
  get head() {
      return ParentNodeUtility_1.default.getElementByTagName(this, 'head');
  }
  /**
   * Returns CSS style sheets.
   *
   * @returns CSS style sheets.
   */
  get styleSheets() {
      const styles = (this.querySelectorAll('link[rel="stylesheet"][href],style'));
      const styleSheets = [];
      for (const style of styles) {
          const sheet = style.sheet;
          if (sheet) {
              styleSheets.push(sheet);
          }
      }
      return styleSheets;
  }
  /**
   * Returns active element.
   *
   * @returns Active element.
   */
  get activeElement() {
      if (this._activeElement) {
          let rootNode = (this._activeElement.getRootNode());
          let activeElement = this._activeElement;
          while (rootNode !== this) {
              activeElement = rootNode.host;
              rootNode = activeElement ? activeElement.getRootNode() : this;
          }
          return activeElement;
      }
      return this._activeElement || this.body || this.documentElement || null;
  }
  /**
   * Returns scrolling element.
   *
   * @returns Scrolling element.
   */
  get scrollingElement() {
      return this.documentElement;
  }
  /**
   * Returns location.
   *
   * @returns Location.
   */
  get location() {
      return this.defaultView.location;
  }
  /**
   * Returns scripts.
   *
   * @returns Scripts.
   */
  get scripts() {
      return this.getElementsByTagName('script');
  }
  /**
   * Returns base URI.
   *
   * @override
   * @returns Base URI.
   */
  get baseURI() {
      const base = this.querySelector('base');
      if (base) {
          return base.href;
      }
      return this.defaultView.location.href;
  }
  /**
   * Inserts a set of Node objects or DOMString objects after the last child of the ParentNode. DOMString objects are inserted as equivalent Text nodes.
   *
   * @param nodes List of Node or DOMString.
   */
  append(...nodes) {
      ParentNodeUtility_1.default.append(this, ...nodes);
  }
  /**
   * Inserts a set of Node objects or DOMString objects before the first child of the ParentNode. DOMString objects are inserted as equivalent Text nodes.
   *
   * @param nodes List of Node or DOMString.
   */
  prepend(...nodes) {
      ParentNodeUtility_1.default.prepend(this, ...nodes);
  }
  /**
   * Replaces the existing children of a node with a specified new set of children.
   *
   * @param nodes List of Node or DOMString.
   */
  replaceChildren(...nodes) {
      ParentNodeUtility_1.default.replaceChildren(this, ...nodes);
  }
  /**
   * Query CSS selector to find matching elments.
   *
   * @param selector CSS selector.
   * @returns Matching elements.
   */
  querySelectorAll(selector) {
      return QuerySelector_1.default.querySelectorAll(this, selector);
  }
  /**
   * Query CSS Selector to find a matching element.
   *
   * @param selector CSS selector.
   * @returns Matching element.
   */
  querySelector(selector) {
      return QuerySelector_1.default.querySelector(this, selector);
  }
  /**
   * Returns an elements by class name.
   *
   * @param className Tag name.
   * @returns Matching element.
   */
  getElementsByClassName(className) {
      return ParentNodeUtility_1.default.getElementsByClassName(this, className);
  }
  /**
   * Returns an elements by tag name.
   *
   * @param tagName Tag name.
   * @returns Matching element.
   */
  getElementsByTagName(tagName) {
      return ParentNodeUtility_1.default.getElementsByTagName(this, tagName);
  }
  /**
   * Returns an elements by tag name and namespace.
   *
   * @param namespaceURI Namespace URI.
   * @param tagName Tag name.
   * @returns Matching element.
   */
  getElementsByTagNameNS(namespaceURI, tagName) {
      return ParentNodeUtility_1.default.getElementsByTagNameNS(this, namespaceURI, tagName);
  }
  /**
   * Returns an element by ID.
   *
   * @param id ID.
   * @returns Matching element.
   */
  getElementById(id) {
      return ParentNodeUtility_1.default.getElementById(this, id);
  }
  /**
   * Returns an element by Name.
   *
   * @returns Matching element.
   * @param name
   */
  getElementsByName(name) {
      const _getElementsByName = (_parentNode, _name) => {
          const matches = HTMLCollectionFactory_1.default.create();
          for (const child of _parentNode.children) {
              if ((child.getAttributeNS(null, 'name') || '') === _name) {
                  matches.push(child);
              }
              for (const match of _getElementsByName(child, _name)) {
                  matches.push(match);
              }
          }
          return matches;
      };
      return _getElementsByName(this, name);
  }
  /**
   * Clones a node.
   *
   * @override
   * @param [deep=false] "true" to clone deep.
   * @returns Cloned node.
   */
  cloneNode(deep = false) {
      this.constructor._defaultView = this.defaultView;
      const clone = super.cloneNode(deep);
      if (deep) {
          for (const node of clone.childNodes) {
              if (node.nodeType === Node_1.default.ELEMENT_NODE) {
                  clone.children.push(node);
              }
          }
      }
      return clone;
  }
  /**
   * Append a child node to childNodes.
   *
   * @override
   * @param  node Node to append.
   * @returns Appended node.
   */
  appendChild(node) {
      // If the type is DocumentFragment, then the child nodes of if it should be moved instead of the actual node.
      // See: https://developer.mozilla.org/en-US/docs/Web/API/DocumentFragment
      if (node.nodeType !== Node_1.default.DOCUMENT_FRAGMENT_NODE) {
          if (node.parentNode && node.parentNode['children']) {
              const index = node.parentNode['children'].indexOf(node);
              if (index !== -1) {
                  node.parentNode['children'].splice(index, 1);
              }
          }
          if (node !== this && node.nodeType === Node_1.default.ELEMENT_NODE) {
              this.children.push(node);
          }
      }
      return super.appendChild(node);
  }
  /**
   * Remove Child element from childNodes array.
   *
   * @override
   * @param node Node to remove.
   */
  removeChild(node) {

      if (node.nodeType === Node_1.default.ELEMENT_NODE) {
          const index = this.children.indexOf(node);
          if (index !== -1) {
              this.children.splice(index, 1);
          }
      }
      return super.removeChild(node);
  }
  /**
   * Inserts a node before another.
   *
   * @override
   * @param newNode Node to insert.
   * @param [referenceNode] Node to insert before.
   * @returns Inserted node.
   */
  insertBefore(newNode, referenceNode) {
      const returnValue = super.insertBefore(newNode, referenceNode);
      // If the type is DocumentFragment, then the child nodes of if it should be moved instead of the actual node.
      // See: https://developer.mozilla.org/en-US/docs/Web/API/DocumentFragment
      if (newNode.nodeType !== Node_1.default.DOCUMENT_FRAGMENT_NODE) {
          if (newNode.parentNode && newNode.parentNode['children']) {
              const index = newNode.parentNode['children'].indexOf(newNode);
              if (index !== -1) {
                  newNode.parentNode['children'].splice(index, 1);
              }
          }
          this.children.length = 0;
          for (const node of this.childNodes) {
              if (node.nodeType === Node_1.default.ELEMENT_NODE) {
                  this.children.push(node);
              }
          }
      }
      return returnValue;
  }
  /**
   * Replaces the document HTML with new HTML.
   *
   * @param html HTML.
   */
  write(html) {
      const root = XMLParser_1.default.parse(this, html, true);
      if (this._isFirstWrite || this._isFirstWriteAfterOpen) {
          if (this._isFirstWrite) {
              if (!this._isFirstWriteAfterOpen) {
                  this.open();
              }
              this._isFirstWrite = false;
          }
          this._isFirstWriteAfterOpen = false;
          let documentElement = null;
          let documentTypeNode = null;
          for (const node of root.childNodes) {
              if (node['tagName'] === 'HTML') {
                  documentElement = node;
              }
              else if (node.nodeType === Node_1.default.DOCUMENT_TYPE_NODE) {
                  documentTypeNode = node;
              }
              if (documentElement && documentTypeNode) {
                  break;
              }
          }
          if (documentElement) {
              if (!this.documentElement) {
                  if (documentTypeNode) {
                      this.appendChild(documentTypeNode);
                  }
                  this.appendChild(documentElement);
              }
              else {
                  const rootBody = root.querySelector('body');
                  const body = this.querySelector('body');
                  if (rootBody && body) {
                      for (const child of rootBody.childNodes.slice()) {
                          body.appendChild(child);
                      }
                  }
              }
              const body = this.querySelector('body');
              if (body) {
                  for (const child of root.childNodes.slice()) {
                      if (child['tagName'] !== 'HTML' && child.nodeType !== Node_1.default.DOCUMENT_TYPE_NODE) {
                          body.appendChild(child);
                      }
                  }
              }
          }
          else {
              const documentElement = this.createElement('html');
              const bodyElement = this.createElement('body');
              const headElement = this.createElement('head');
              for (const child of root.childNodes.slice()) {
                  bodyElement.appendChild(child);
              }
              documentElement.appendChild(headElement);
              documentElement.appendChild(bodyElement);
              this.appendChild(documentElement);
          }
      }
      else {
          const bodyNode = root.querySelector('body');
          for (const child of (bodyNode || root).childNodes.slice()) {
              this.body.appendChild(child);
          }
      }
  }
  /**
   * Opens the document.
   *
   * @returns Document.
   */
  open() {
      this._isFirstWriteAfterOpen = true;
      for (const eventType of Object.keys(this._listeners)) {
          const listeners = this._listeners[eventType];
          if (listeners) {
              for (const listener of listeners) {
                  this.removeEventListener(eventType, listener);
              }
          }
      }
      for (const child of this.childNodes.slice()) {
          this.removeChild(child);
      }
      return this;
  }
  /**
   * Closes the document.
   */
  close() { }
  /* eslint-disable jsdoc/valid-types */
  /**
   * Creates an element.
   *
   * @param qualifiedName Tag name.
   * @param [options] Options.
   * @param [options.is] Tag name of a custom element previously defined via customElements.define().
   * @returns Element.
   */
  createElement(qualifiedName, options) {
      return this.createElementNS(NamespaceURI_1.default.html, qualifiedName, options);
  }
  /**
   * Creates an element with the specified namespace URI and qualified name.
   *
   * @param namespaceURI Namespace URI.
   * @param qualifiedName Tag name.
   * @param [options] Options.
   * @param [options.is] Tag name of a custom element previously defined via customElements.define().
   * @returns Element.
   */
  createElementNS(namespaceURI, qualifiedName, options) {
      const tagName = String(qualifiedName).toUpperCase();
      let customElementClass;
      if (this.defaultView && options && options.is) {
          customElementClass = this.defaultView.customElements.get(String(options.is));
      }
      else if (this.defaultView) {
          customElementClass = this.defaultView.customElements.get(tagName);
      }
      const elementClass = customElementClass || HTMLUnknownElement_1.default;
      elementClass._ownerDocument = this;
      const element = new elementClass();
      element.tagName = tagName;
      element.ownerDocument = this;
      element.namespaceURI = namespaceURI;
      if (element instanceof Element_1.default && options && options.is) {
          element._isValue = String(options.is);
      }
      return element;
  }
  /* eslint-enable jsdoc/valid-types */
  /**
   * Creates a text node.
   *
   * @param [data] Text data.
   * @returns Text node.
   */
  createTextNode(data) {
      Text_1.default._ownerDocument = this;
      return new Text_1.default(data);
  }
  /**
   * Creates a comment node.
   *
   * @param [data] Text data.
   * @returns Text node.
   */
  createComment(data) {
      Comment_1.default._ownerDocument = this;
      return new Comment_1.default(data);
  }
  /**
   * Creates a document fragment.
   *
   * @returns Document fragment.
   */
  createDocumentFragment() {
      DocumentFragment_1.default._ownerDocument = this;
      return new DocumentFragment_1.default();
  }
  /**
   * Creates a Tree Walker.
   *
   * @param root Root.
   * @param [whatToShow] What to show.
   * @param [filter] Filter.
   */
  createTreeWalker(root, whatToShow = -1, filter = null) {
      return new TreeWalker_1.default(root, whatToShow, filter);
  }
  /**
   * Creates an event.
   *
   * @deprecated
   * @param type Type.
   * @returns Event.
   */
  createEvent(type) {
      if (typeof this.defaultView[type] === 'function') {
          return new this.defaultView[type]('init');
      }
      return new Event_1.default('init');
  }
  /**
   * Creates an Attr node.
   *
   * @param name Name.
   * @returns Attribute.
   */
  createAttribute(name) {
      const attribute = new Attr_1.default();
      attribute.name = name.toLowerCase();
      attribute.ownerDocument = this;
      return attribute;
  }
  /**
   * Creates a namespaced Attr node.
   *
   * @param namespaceURI Namespace URI.
   * @param qualifiedName Qualified name.
   * @returns Element.
   */
  createAttributeNS(namespaceURI, qualifiedName) {
      const attribute = new Attr_1.default();
      attribute.namespaceURI = namespaceURI;
      attribute.name = qualifiedName;
      attribute.ownerDocument = this;
      return attribute;
  }
  /**
   * Imports a node.
   *
   * @param node Node to import.
   * @param [deep=false] Set to "true" if the clone should be deep.
   * @param Imported Node.
   */
  importNode(node, deep = false) {
      if (!(node instanceof Node_1.default)) {
          throw new DOMException_1.default('Parameter 1 was not of type Node.');
      }
      const clone = node.cloneNode(deep);
      clone.ownerDocument = this;
      return clone;
  }
  /**
   * Creates a range.
   *
   * @returns Range.
   */
  createRange() {
      return new this.defaultView.Range();
  }
  /**
   * Adopts a node.
   *
   * @param node Node to adopt.
   * @returns Adopted node.
   */
  adoptNode(node) {
      if (!(node instanceof Node_1.default)) {
          throw new DOMException_1.default('Parameter 1 was not of type Node.');
      }
      const adopted = node.parentNode ? node.parentNode.removeChild(node) : node;
      adopted.ownerDocument = this;
      return adopted;
  }
  /**
   * Returns selection.
   *
   * @returns Selection.
   */
  getSelection() {
      if (!this._selection) {
          this._selection = new Selection_1.default(this);
      }
      return this._selection;
  }
  /**
   * Returns a boolean value indicating whether the document or any element inside the document has focus.
   *
   * @returns "true" if the document has focus.
   */
  hasFocus() {
      return !!this.activeElement;
  }
  /**
   * @override
   */
  dispatchEvent(event) {
      const returnValue = super.dispatchEvent(event);
      if (event.bubbles && !event._propagationStopped) {
          return this.defaultView.dispatchEvent(event);
      }
      return returnValue;
  }
  /**
   * Triggered by window when it is ready.
   */
  _onWindowReady() {
      this._readyStateManager.whenComplete().then(() => {
          this.readyState = DocumentReadyStateEnum_1.default.complete;
          this.dispatchEvent(new Event_1.default('readystatechange'));
          this.dispatchEvent(new Event_1.default('load', { bubbles: true }));
      });
  }
}

export default Document;
//# sourceMappingURL=Document.js.map
