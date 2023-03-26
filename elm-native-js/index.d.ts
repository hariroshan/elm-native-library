import * as NativescriptCore from "./types/Native/NativescriptCore.bs";
declare function render(current: any, param: any): void;

type nativeObject = any
type port = any
/* You don't have to build this object from scratch. You can use helper function in
  buildHandler in Native/Elements.bs for UI elements
  buildHandler in Native/Layouts.bs for Layouts
*/
type handler = {
  /* A function to create Nativescript object */
  init: () => nativeObject;
  /* An array of attribute strings in Kebab Case. Use kebabCased function in Native/Constants.bs to convert your camel cased attributes to kebab case
   * Don't forget to call prefixWithBind(withTransformedArrayOfStrings) if you want to use the attributes in a bindExpression
   */
  observedAttributes: string[];
  update: typeof NativescriptCore.update;
  render: any;
  handlerKind: number;
  dispose: typeof NativescriptCore.dispose;
  addEventListener: typeof NativescriptCore.addEventListener;
  removeEventListener: typeof NativescriptCore.removeEventListener;
}
type customElement = {
  tagName: string,
  handler: handler,
}
type config = {
  elmModule: () => any,
  elmModuleName: string,
  flags?: any,
  initPorts?: (ports: port) => void,
  /*
  Here's how you can define your own customElements and use in elm
  import { buildHandler, addViewRender } from "elm-native-js/src/Native/Elements.bs"
  import { kebabCased, view } from "elm-native-js/src/Native/Constants.bs"
  import SomePlugin from 'some-native-script-plugin'

  ...
  const somePluginAttributes = ['attributeToWatch1', 'attributeToWatch2'].map(kebabCased)
  // If you want to use it in a bind expression, call prefixWithBind(somePluginAttributes) exported from Native/Constants.bs

  ...

  const config = {
    ...
    customElements:
      [ { tagName: 'ns-some-tag-name',
          handler: buildHandler(
            () => new SomePlugin(),
            view.concat(somePluginAttributes),
            addViewRender // For most cases, this is what you need. Refer Native/Elements.bs and Native/Helper.bs for other kinds
          )
        }
      ]
  }

  start(config)
  */
  customElements?: customElement[],
}

export function start(config: config): void;
