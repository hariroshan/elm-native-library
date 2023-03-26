let makeRender = helperAdd =>
  Js.Nullable.return((. current: Types.htmlElement, _) =>
    helperAdd(. current.parentElement, current)
  )

let buildHandler: (
  unit => Types.nativeObject,
  array<string>,
  Js.Nullable.t<(. Types.htmlElement, Types.nativeObject) => unit>,
) => Types.handler = (new, observedAttributes, render) => {
  init: (. ()) => new(),
  observedAttributes,
  render,
  handlerKind: Types.Element,
  update: NativescriptCore.update,
  dispose: NativescriptCore.dispose,
  addEventListener: NativescriptCore.addEventListener,
  removeEventListener: NativescriptCore.removeEventListener,
}

let addViewRender: Js.Nullable.t<(. Types.htmlElement, Types.nativeObject) => unit> = makeRender(Helper.addView)

module Label = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Label"
  )
  let tagName = "ns-label"

  let handler: Types.handler = buildHandler(new, Constants.textBase, addViewRender)
}

module Button = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Button"
  )
  let tagName = "ns-button"

  let handler: Types.handler = buildHandler(new, Constants.button, addViewRender)
}

module Placeholder = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Placeholder"
  )
  let tagName = "ns-placeholder"

  let handler: Types.handler = buildHandler(new, Constants.view, addViewRender)
}

module ActionBar = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "ActionBar"
  )
  let tagName = "ns-action-bar"

  let handler: Types.handler = buildHandler(
    new,
    Constants.actionBar,
    makeRender(Helper.addActionBar),
  )
}

module ActionItem = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "ActionItem"
  )
  let tagName = "ns-action-item"

  let handler: Types.handler = buildHandler(
    new,
    Constants.actionItem,
    makeRender(Helper.addActionItem),
  )
}

module NavigationButton = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "NavigationButton"
  )
  let tagName = "ns-navigation-button"

  let handler: Types.handler = buildHandler(
    new,
    Constants.navigationButton,
    makeRender(Helper.addNavigationButton),
  )
}

module ActivityIndicator = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "ActivityIndicator"
  )
  let tagName = "ns-activity-indicator"
  let handler: Types.handler = buildHandler(
    new,
    Constants.activityIndicator,
    addViewRender,
  )
}

module FormattedString = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "FormattedString"
  )
  let tagName = "ns-formatted-string"

  let handler: Types.handler = buildHandler(
    new,
    Constants.formattedString,
    makeRender(Helper.addFormattedText),
  )
}
module Span = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Span"
  )
  let tagName = "ns-span"

  let handler: Types.handler = buildHandler(new, Constants.span, makeRender(Helper.addSpan))
}
module DatePicker = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "DatePicker"
  )
  let tagName = "ns-datepicker"

  let handler: Types.handler = buildHandler(new, Constants.datePicker, addViewRender)
}
module HtmlView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "HtmlView"
  )
  let tagName = "ns-html-view"

  let handler: Types.handler = buildHandler(new, Constants.htmlView, addViewRender)
}
module Image = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Image"
  )
  let tagName = "ns-image"

  let handler: Types.handler = buildHandler(new, Constants.image, addViewRender)
}

module Progress = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Progress"
  )
  let tagName = "ns-progress"

  let handler: Types.handler = buildHandler(new, Constants.progress, addViewRender)
}
module ListPicker = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "ListPicker"
  )
  let setItems = (current: Types.htmlElement, data) => {
    data->Types.setItems(current.items)
  }
  let tagName = "ns-list-picker"

  let handler: Types.handler = buildHandler(
    new,
    Constants.listPicker,
    Js.Nullable.return((. current: Types.htmlElement, _) => {
      current.data->Js.Nullable.toOption->Belt.Option.forEach(setItems(current))
      Types.definePropertyInHtml(. current, "items", {set: setItems(current)})
      Helper.addView(. current.parentElement, current)
    }),
  )
}
module ScrollView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "ScrollView"
  )
  let tagName = "ns-scroll-view"

  let handler: Types.handler = buildHandler(new, Constants.scrollView, addViewRender)
}

module SearchBar = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "SearchBar"
  )
  let tagName = "ns-search-bar"

  let handler: Types.handler = buildHandler(new, Constants.searchBar, addViewRender)
}

module SegmentedBar = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "SegmentedBar"
  )
  let tagName = "ns-segmented-bar"

  let handler: Types.handler = buildHandler(new, Constants.segmentedBar, addViewRender)
}

module SegmentedBarItem = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "SegmentedBarItem"
  )
  let tagName = "ns-segmented-bar-item"

  let handler: Types.handler = buildHandler(
    new,
    Constants.segmentedBarItem,
    makeRender(Helper.addItems),
  )
}

module Slider = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Slider"
  )
  let tagName = "ns-slider"

  let handler: Types.handler = buildHandler(new, Constants.slider, addViewRender)
}

module Switch = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "Switch"
  )
  let tagName = "ns-switch"

  let handler: Types.handler = buildHandler(
    new,
    Constants.switchComponent,
    addViewRender,
  )
}

module TabView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "TabView"
  )
  let tagName = "ns-tab-view"

  let handler: Types.handler = buildHandler(new, Constants.tabView, addViewRender)
}

module TabViewItem = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "TabViewItem"
  )
  let tagName = "ns-tab-view-item"
  let handler: Types.handler = buildHandler(
    new,
    Constants.tabViewItem,
    Js.Nullable.return((. current: Types.htmlElement, data: Types.nativeObject) => {
      current.children
      ->Belt.Array.get(0)
      ->Belt.Option.map((ch: Types.htmlElement) => {
        data->Types.setView(ch.data)
      })
      ->ignore

      Helper.addItems(. current.parentElement, current)
    }),
  )
}

module TextField = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "TextField"
  )
  let tagName = "ns-textfield"

  let handler: Types.handler = buildHandler(new, Constants.textField, addViewRender)
}

module TextView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "TextView"
  )
  let tagName = "ns-text-view"

  let handler: Types.handler = buildHandler(new, Constants.textView, addViewRender)
}

module TimePicker = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "TimePicker"
  )
  let tagName = "ns-time-picker"

  let handler: Types.handler = buildHandler(new, Constants.timePicker, addViewRender)
}

module WebView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "WebView"
  )
  let tagName = "ns-web-view"

  let handler: Types.handler = buildHandler(new, Constants.webView, addViewRender)
}
module ListView = {
  %%private(
    @module("@nativescript/core") @new
    external new: unit => Types.nativeObject = "ListView"

    let itemsSetter = (data: Types.nativeObject, newItems) => {
      data->Types.setItems(newItems)
      data->Types.refresh
    }
  )
  let tagName = "ns-list-view"

  let handler: Types.handler = buildHandler(
    new,
    Constants.listView,
    Js.Nullable.return((. current: Types.htmlElement, data: Types.nativeObject) => {
      ListPicker.setItems(current, data)
      Types.definePropertyInHtml(. current, "items", {set: itemsSetter(data)})
      Helper.addView(. current.parentElement, current)
    }),
  )
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
  {
    tagName: ActionBar.tagName,
    handler: ActionBar.handler,
  },
  {
    tagName: ActionItem.tagName,
    handler: ActionItem.handler,
  },
  {
    tagName: NavigationButton.tagName,
    handler: NavigationButton.handler,
  },
  {
    tagName: ListView.tagName,
    handler: ListView.handler,
  },
  {
    tagName: Placeholder.tagName,
    handler: Placeholder.handler,
  },
]
