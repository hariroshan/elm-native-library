let all: array<Types.customElement>
let addViewRender: Js.Nullable.t<(. Types.htmlElement, Types.nativeObject) => unit>
let buildHandler: (
  unit => Types.nativeObject,
  array<string>,
  Js.Nullable.t<(. Types.htmlElement, Types.nativeObject) => unit>,
) => Types.handler
