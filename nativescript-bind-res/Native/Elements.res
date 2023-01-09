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
module HtmlView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "HtmlView"
  )
  let tagName = "ns-html-view"

  let handler: Types.handler = buildHandler(new, Constants.htmlView, Helper.addView)
}
module Image = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Image"
  )
  let tagName = "ns-image"

  let handler: Types.handler = buildHandler(new, Constants.image, Helper.addView)
}

module Progress = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Progress"
  )
  let tagName = "ns-progress"

  let handler: Types.handler = buildHandler(new, Constants.progress, Helper.addView)
}
module ListPicker = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "ListPicker"
    let setItems = (current: Types.htmlElement, data) => {
      data->Types.setItems(current.items)
    }
  )
  let tagName = "ns-list-picker"

  /* TODO: Listen for changes in items property */
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.listPicker,
    render: Js.Nullable.return((. current: Types.htmlElement, _) => {
      current.data->Js.Nullable.toOption->Belt.Option.forEach(setItems(current))
      Types.definePropertyInHtml(. current, "items", {set: setItems(current)})
      Helper.addView(. current.parentElement, current)
    }),
    handlerKind: Types.Element,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}
module ScrollView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "ScrollView"
  )
  let tagName = "ns-scroll-view"

  let handler: Types.handler = buildHandler(new, Constants.scrollView, Helper.addView)
}

module SearchBar = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "SearchBar"
  )
  let tagName = "ns-search-bar"

  let handler: Types.handler = buildHandler(new, Constants.searchBar, Helper.addView)
}

module SegmentedBar = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "SegmentedBar"
  )
  let tagName = "ns-segmented-bar"

  let handler: Types.handler = buildHandler(new, Constants.segmentedBar, Helper.addView)
}

module SegmentedBarItem = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "SegmentedBarItem"
  )
  let tagName = "ns-segmented-bar-item"

  let handler: Types.handler = buildHandler(new, Constants.segmentedBarItem, Helper.addItems)
}

module Slider = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Slider"
  )
  let tagName = "ns-slider"

  let handler: Types.handler = buildHandler(new, Constants.slider, Helper.addView)
}

module Switch = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Switch"
  )
  let tagName = "ns-switch"

  let handler: Types.handler = buildHandler(new, Constants.switchComponent, Helper.addView)
}

module TabView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "TabView"
  )
  let tagName = "ns-tab-view"

  let handler: Types.handler = buildHandler(new, Constants.tabView, Helper.addView)
}

module TabViewItem = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "TabViewItem"
  )
  let tagName = "ns-tab-view-item"
  let handler: Types.handler = {
    init: (. ()) => new(),
    observedAttributes: Constants.tabViewItem,
    render: Js.Nullable.return((. current: Types.htmlElement, _) => {
      current.children
      ->Belt.Array.get(0)
      ->Belt.Option.forEach(ch => {
        current.data
        ->Js.Nullable.toOption
        ->Belt.Option.forEach(data => data->Types.setView(ch.data))
      })

      Helper.addItems(. current.parentElement, current)
    }),
    handlerKind: Types.Element,
    update: NativescriptCore.update,
    dispose: NativescriptCore.dispose,
    addEventListener: NativescriptCore.addEventListener,
    removeEventListener: NativescriptCore.removeEventListener,
  }
}

module TextField = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "TextField"
  )
  let tagName = "ns-textfield"

  let handler: Types.handler = buildHandler(new, Constants.textField, Helper.addView)
}

module TextView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "TextView"
  )
  let tagName = "ns-text-view"

  let handler: Types.handler = buildHandler(new, Constants.textView, Helper.addView)
}

module TimePicker = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "TimePicker"
  )
  let tagName = "ns-time-picker"

  let handler: Types.handler = buildHandler(new, Constants.timePicker, Helper.addView)
}

module WebView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "WebView"
  )
  let tagName = "ns-web-view"

  let handler: Types.handler = buildHandler(new, Constants.webView, Helper.addView)
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
  {
    tagName: HtmlView.tagName,
    handler: HtmlView.handler,
  },
  {
    tagName: Image.tagName,
    handler: Image.handler,
  },
  {
    tagName: ListPicker.tagName,
    handler: ListPicker.handler,
  },
  {
    tagName: Progress.tagName,
    handler: Progress.handler,
  },
  {
    tagName: ScrollView.tagName,
    handler: ScrollView.handler,
  },
  {
    tagName: SearchBar.tagName,
    handler: SearchBar.handler,
  },
  {
    tagName: SegmentedBar.tagName,
    handler: SegmentedBar.handler,
  },
  {
    tagName: SegmentedBarItem.tagName,
    handler: SegmentedBarItem.handler,
  },
  {
    tagName: Slider.tagName,
    handler: Slider.handler,
  },
  {
    tagName: Switch.tagName,
    handler: Switch.handler,
  },
  {
    tagName: TabView.tagName,
    handler: TabView.handler,
  },
  {
    tagName: TabViewItem.tagName,
    handler: TabViewItem.handler,
  },
  {
    tagName: TextField.tagName,
    handler: TextField.handler,
  },
  {
    tagName: TextView.tagName,
    handler: TextView.handler,
  },
  {
    tagName: TimePicker.tagName,
    handler: TimePicker.handler,
  },
  {
    tagName: WebView.tagName,
    handler: WebView.handler,
  },
]
