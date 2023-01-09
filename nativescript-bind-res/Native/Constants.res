let camelCased: string => string = %raw(`
  function(str) {
    return str.replace(/-([a-z])/g, function (g) { return g[1].toUpperCase(); });
  }
`)

let dashed: string => string = %raw(`
    function(str) {
        return str.replace(/[A-Z]/g, m => "-" + m.toLowerCase());
    }
    `)
/* copy(Array.from(temp1.children).map(x => x.innerText).filter(x => !(x.startsWith('_') || x.endsWith("Event"))).filter(x => !textBase.includes(x))) */
let view: array<string> =
  [
    "accessibilityHidden",
    "accessibilityHint",
    "accessibilityIdentifier",
    "accessibilityLabel",
    "accessibilityLanguage",
    "accessibilityLiveRegion",
    "accessibilityMediaSession",
    "accessibilityRole",
    "accessibilityState",
    "accessibilityValue",
    "accessible",
    "alignSelf",
    "android",
    "androidDynamicElevationOffset",
    "androidElevation",
    "automationText",
    "background",
    "backgroundColor",
    "backgroundImage",
    "bindingContext",
    "borderBottomColor",
    "borderBottomLeftRadius",
    "borderBottomRightRadius",
    "borderBottomWidth",
    "borderColor",
    "borderLeftColor",
    "borderLeftWidth",
    "borderRadius",
    "borderRightColor",
    "borderRightWidth",
    "borderTopColor",
    "borderTopLeftRadius",
    "borderTopRightRadius",
    "borderTopWidth",
    "borderWidth",
    "boxShadow",
    "className",
    "col",
    "colSpan",
    "color",
    "column",
    "columnSpan",
    "css",
    "cssClasses",
    "cssPseudoClasses",
    "cssType",
    "dock",
    "domNode",
    "effectiveBorderBottomWidth",
    "effectiveBorderLeftWidth",
    "effectiveBorderRightWidth",
    "effectiveBorderTopWidth",
    "effectiveHeight",
    "effectiveLeft",
    "effectiveMarginBottom",
    "effectiveMarginLeft",
    "effectiveMarginRight",
    "effectiveMarginTop",
    "effectiveMinHeight",
    "effectiveMinWidth",
    "effectivePaddingBottom",
    "effectivePaddingLeft",
    "effectivePaddingRight",
    "effectivePaddingTop",
    "effectiveTop",
    "effectiveWidth",
    "flexGrow",
    "flexShrink",
    "flexWrapBefore",
    "height",
    "horizontalAlignment",
    "id",
    "ios",
    "iosIgnoreSafeArea",
    "iosOverflowSafeArea",
    "iosOverflowSafeAreaEnabled",
    "isCollapsed",
    "isEnabled",
    "isLayoutRequired",
    "isLayoutValid",
    "isUserInteractionEnabled",
    "left",
    "margin",
    "marginBottom",
    "marginLeft",
    "marginRight",
    "marginTop",
    "minHeight",
    "minWidth",
    "modal",
    "nativeViewProtected",
    "opacity",
    "order",
    "originX",
    "originY",
    "parent",
    "perspective",
    "recycleNativeView",
    "reusable",
    "rotate",
    "rotateX",
    "rotateY",
    "row",
    "rowSpan",
    "scaleX",
    "scaleY",
    "top",
    "translateX",
    "translateY",
    "verticalAlignment",
    "viewController",
    "visibility",
    "width",
  ]->Belt.Array.map(dashed)

let paddings: array<string> =
  ["padding", "paddingBottom", "paddingLeft", "paddingRight", "paddingTop"]->Belt.Array.map(dashed)

let layoutBase: array<string> =
  [
    view,
    paddings,
    ["clipToBounds", "isPassThroughParentEnabled"]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let textBase: array<string> =
  [
    view,
    paddings,
    [
      "fontSize",
      "formattedText",
      "letterSpacing",
      "lineHeight",
      "nativeTextViewProtected",
      "text",
      "textAlignment",
      "textDecoration",
      "textShadow",
      "textTransform",
      "whiteSpace",
      "textWrap",
    ]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let dockLayout: array<string> =
  [layoutBase, ["stretchLastChild"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let gridLayout: array<string> =
  [layoutBase, ["columns", "rows"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let stackLayout: array<string> =
  [layoutBase, ["orientation"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let wrapLayout: array<string> =
  [stackLayout, ["itemHeight", "itemWidth"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let flexboxLayout: array<string> =
  [
    layoutBase,
    ["alignContent", "alignItems", "flexDirection", "flexWrap", "justifyContent"]->Belt.Array.map(
      dashed,
    ),
  ]->Belt.Array.concatMany

let button = [textBase, ["textWrap"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let frameBase =
  [
    view,
    [
      "actionBarVisibility",
      "animated",
      "transition",
      "defaultAnimatedNavigation",
      "defaultTransition",
    ]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let pageBase =
  [
    view,
    [
      "accessibilityAnnouncePageEnabled",
      "actionBarHidden",
      "androidStatusBarBackground",
      "backgroundSpanUnderStatusBar",
      "enableSwipeBackNavigation",
      "statusBarStyle",
    ]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let activityIndicator = [view, ["busy"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

/* for simplicity using view instead of viewBase */
let formattedString =
  [
    view,
    ["fontStyle", "style", "fontFamily", "fontWeight"]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let span = [formattedString, ["text"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let datePicker =
  [
    view,
    [
      "date",
      "day",
      "iosPreferredDatePickerStyle",
      "maxDate",
      "minDate",
      "month",
      "year",
    ]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let htmlView = [view, ["html"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let image =
  [
    view,
    [
      "decodeHeight",
      "decodeWidth",
      "imageSource",
      "isLoading",
      "loadMode",
      "src",
      "stretch",
      "tintColor",
    ]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let listPicker = [view, ["selectedIndex"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let progress = [view, ["maxValue", "value"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let scrollView =
  [
    view,
    [
      "horizontalOffset",
      "isScrollEnabled",
      "orientation",
      "scrollBarIndicatorVisible",
      "scrollableHeight",
      "scrollableWidth",
      "verticalOffset",
    ]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let searchBar =
  [
    view,
    ["hint", "text", "textFieldBackgroundColor", "textFieldHintColor"]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let segmentedBarItem = [view, ["title"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let segmentedBar =
  [
    view,
    ["selectedBackgroundColor", "selectedIndex"]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let slider =
  [view, ["value", "minValue", "maxValue"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let switchComponent = [view, ["checked"]->Belt.Array.map(dashed)]->Belt.Array.concatMany

let tabView =
  [
    view,
    [
      "androidOffscreenTabLimit",
      "androidSelectedTabHighlightColor",
      "androidSwipeEnabled",
      "androidTabsPosition",
      "iosIconRenderingMode",
      "selectedIndex",
      "selectedTabTextColor",
      "tabBackgroundColor",
      "tabTextColor",
      "tabTextFontSize",
    ]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

let tabViewItem =
  [
    view,
    ["canBeLoaded", "iconSource", "textTransform", "title"]->Belt.Array.map(dashed),
  ]->Belt.Array.concatMany

// Js.log("****************************")
// ["canBeLoaded", "iconSource", "textTransform", "title"]
// ->Belt.Array.map(dashed)
// ->Belt.Array.forEach(prop =>
//   Js.log(
//     `
// ${camelCased(prop)} =  attribute "${prop}"
//     `,
//   )
// )

// Js.log("****************************")
