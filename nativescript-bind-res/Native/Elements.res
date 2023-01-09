let render = helperAdd =>
  Js.Nullable.return((. current: Types.htmlElement, _) =>
    helperAdd(. current.parentElement, current)
  )

let buildHandler: (
  unit => Types.nativeObject,
  array<string>,
  (. Types.htmlElement, Types.htmlElement) => unit,
) => Types.handler = (new, observedAttributes, helperAdd) => {
  init: (. ()) => new(),
  observedAttributes,
  render: render(helperAdd),
  handlerKind: Types.Element,
  update: NativescriptCore.update,
  dispose: NativescriptCore.dispose,
  addEventListener: NativescriptCore.addEventListener,
  removeEventListener: NativescriptCore.removeEventListener,
}

module Label = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Label"
  )
  let tagName = "ns-label"

  let handler: Types.handler = buildHandler(new, Constants.textBase, Helper.addView)
}

module Button = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Button"
  )
  let tagName = "ns-button"

  let handler: Types.handler = buildHandler(new, Constants.button, Helper.addView)
}

module ActivityIndicator = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "ActivityIndicator"
  )
  let tagName = "ns-activity-indicator"
  let handler: Types.handler = buildHandler(new, Constants.activityIndicator, Helper.addView)
}

module FormattedString = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "FormattedString"
  )
  let tagName = "ns-formatted-string"

  let handler: Types.handler = buildHandler(new, Constants.formattedString, Helper.addFormattedText)
}
module Span = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Span"
  )
  let tagName = "ns-span"

  let handler: Types.handler = buildHandler(new, Constants.span, Helper.addSpan)
}
module DatePicker = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "DatePicker"
  )
  let tagName = "ns-datepicker"

  let handler: Types.handler = buildHandler(new, Constants.datePicker, Helper.addView)
}

let all: array<Types.customElement> = [
  {
    tagName: Label.tagName,
    handler: Label.handler,
  },
  {
    tagName: Button.tagName,
    handler: Button.handler,
  },
  {
    tagName: ActivityIndicator.tagName,
    handler: ActivityIndicator.handler,
  },
  {
    tagName: FormattedString.tagName,
    handler: FormattedString.handler,
  },
  {
    tagName: Span.tagName,
    handler: Span.handler,
  },
  {
    tagName: DatePicker.tagName,
    handler: DatePicker.handler,
  },
]
