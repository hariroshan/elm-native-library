module Native.Attributes exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (attribute, property)
import Json.Encode as E
import Native exposing (ListViewModel)


fontSize : String -> Attribute msg
fontSize =
    attribute "font-size"


fontWeight : String -> Attribute msg
fontWeight =
    attribute "font-weight"


fontStyle : String -> Attribute msg
fontStyle =
    attribute "font-style"


formattedText : String -> Attribute msg
formattedText =
    attribute "formatted-text"


letterSpacing : String -> Attribute msg
letterSpacing =
    attribute "letter-spacing"


lineHeight : String -> Attribute msg
lineHeight =
    attribute "line-height"


nativeTextViewProtected : String -> Attribute msg
nativeTextViewProtected =
    attribute "native-text-view-protected"


text : String -> Attribute msg
text =
    attribute "text"


key : String -> Attribute msg
key =
    attribute "key"


icon : String -> Attribute msg
icon =
    attribute "icon"


style : String -> Attribute msg
style =
    attribute "style"


textAlignment : String -> Attribute msg
textAlignment =
    attribute "text-alignment"


textDecoration : String -> Attribute msg
textDecoration =
    attribute "text-decoration"


textShadow : String -> Attribute msg
textShadow =
    attribute "text-shadow"


textTransform : String -> Attribute msg
textTransform =
    attribute "text-transform"


whiteSpace : String -> Attribute msg
whiteSpace =
    attribute "white-space"


stretchLastChild : String -> Attribute msg
stretchLastChild =
    attribute "stretch-last-child"


orientation : String -> Attribute msg
orientation =
    attribute "orientation"


itemHeight : String -> Attribute msg
itemHeight =
    attribute "item-height"


itemWidth : String -> Attribute msg
itemWidth =
    attribute "item-width"


alignContent : String -> Attribute msg
alignContent =
    attribute "align-content"


alignItems : String -> Attribute msg
alignItems =
    attribute "align-items"


flexDirection : String -> Attribute msg
flexDirection =
    attribute "flex-direction"


flexWrap : String -> Attribute msg
flexWrap =
    attribute "flex-wrap"


justifyContent : String -> Attribute msg
justifyContent =
    attribute "justify-content"


padding : String -> Attribute msg
padding =
    attribute "padding"


paddingBottom : String -> Attribute msg
paddingBottom =
    attribute "padding-bottom"


paddingLeft : String -> Attribute msg
paddingLeft =
    attribute "padding-left"


paddingRight : String -> Attribute msg
paddingRight =
    attribute "padding-right"


paddingTop : String -> Attribute msg
paddingTop =
    attribute "padding-top"


accessibilityHidden : String -> Attribute msg
accessibilityHidden =
    attribute "accessibility-hidden"


accessibilityHint : String -> Attribute msg
accessibilityHint =
    attribute "accessibility-hint"


accessibilityIdentifier : String -> Attribute msg
accessibilityIdentifier =
    attribute "accessibility-identifier"


accessibilityLabel : String -> Attribute msg
accessibilityLabel =
    attribute "accessibility-label"


accessibilityLanguage : String -> Attribute msg
accessibilityLanguage =
    attribute "accessibility-language"


accessibilityLiveRegion : String -> Attribute msg
accessibilityLiveRegion =
    attribute "accessibility-live-region"


accessibilityMediaSession : String -> Attribute msg
accessibilityMediaSession =
    attribute "accessibility-media-session"


accessibilityRole : String -> Attribute msg
accessibilityRole =
    attribute "accessibility-role"


accessibilityState : String -> Attribute msg
accessibilityState =
    attribute "accessibility-state"


accessibilityValue : String -> Attribute msg
accessibilityValue =
    attribute "accessibility-value"


accessible : String -> Attribute msg
accessible =
    attribute "accessible"


alignSelf : String -> Attribute msg
alignSelf =
    attribute "align-self"


androidDynamicElevationOffset : String -> Attribute msg
androidDynamicElevationOffset =
    attribute "android-dynamic-elevation-offset"


androidElevation : String -> Attribute msg
androidElevation =
    attribute "android-elevation"


automationText : String -> Attribute msg
automationText =
    attribute "automation-text"


background : String -> Attribute msg
background =
    attribute "background"


backgroundColor : String -> Attribute msg
backgroundColor =
    attribute "background-color"


backgroundImage : String -> Attribute msg
backgroundImage =
    attribute "background-image"


borderBottomColor : String -> Attribute msg
borderBottomColor =
    attribute "border-bottom-color"


borderBottomLeftRadius : String -> Attribute msg
borderBottomLeftRadius =
    attribute "border-bottom-left-radius"


borderBottomRightRadius : String -> Attribute msg
borderBottomRightRadius =
    attribute "border-bottom-right-radius"


borderBottomWidth : String -> Attribute msg
borderBottomWidth =
    attribute "border-bottom-width"


borderColor : String -> Attribute msg
borderColor =
    attribute "border-color"


borderLeftColor : String -> Attribute msg
borderLeftColor =
    attribute "border-left-color"


borderLeftWidth : String -> Attribute msg
borderLeftWidth =
    attribute "border-left-width"


borderRadius : String -> Attribute msg
borderRadius =
    attribute "border-radius"


borderRightColor : String -> Attribute msg
borderRightColor =
    attribute "border-right-color"


borderRightWidth : String -> Attribute msg
borderRightWidth =
    attribute "border-right-width"


borderTopColor : String -> Attribute msg
borderTopColor =
    attribute "border-top-color"


borderTopLeftRadius : String -> Attribute msg
borderTopLeftRadius =
    attribute "border-top-left-radius"


borderTopRightRadius : String -> Attribute msg
borderTopRightRadius =
    attribute "border-top-right-radius"


borderTopWidth : String -> Attribute msg
borderTopWidth =
    attribute "border-top-width"


borderWidth : String -> Attribute msg
borderWidth =
    attribute "border-width"


boxShadow : String -> Attribute msg
boxShadow =
    attribute "box-shadow"


class : String -> Attribute msg
class =
    attribute "class-name"


col : String -> Attribute msg
col =
    attribute "col"


colSpan : String -> Attribute msg
colSpan =
    attribute "col-span"


color : String -> Attribute msg
color =
    attribute "color"


column : String -> Attribute msg
column =
    attribute "column"


columns : String -> Attribute msg
columns =
    attribute "columns"


columnSpan : String -> Attribute msg
columnSpan =
    attribute "column-span"


css : String -> Attribute msg
css =
    attribute "css"


cssClasses : String -> Attribute msg
cssClasses =
    attribute "css-classes"


cssPseudoClasses : String -> Attribute msg
cssPseudoClasses =
    attribute "css-pseudo-classes"


cssType : String -> Attribute msg
cssType =
    attribute "css-type"


dock : String -> Attribute msg
dock =
    attribute "dock"


domNode : String -> Attribute msg
domNode =
    attribute "dom-node"


effectiveBorderBottomWidth : String -> Attribute msg
effectiveBorderBottomWidth =
    attribute "effective-border-bottom-width"


effectiveBorderLeftWidth : String -> Attribute msg
effectiveBorderLeftWidth =
    attribute "effective-border-left-width"


effectiveBorderRightWidth : String -> Attribute msg
effectiveBorderRightWidth =
    attribute "effective-border-right-width"


effectiveBorderTopWidth : String -> Attribute msg
effectiveBorderTopWidth =
    attribute "effective-border-top-width"


effectiveHeight : String -> Attribute msg
effectiveHeight =
    attribute "effective-height"


effectiveLeft : String -> Attribute msg
effectiveLeft =
    attribute "effective-left"


effectiveMarginBottom : String -> Attribute msg
effectiveMarginBottom =
    attribute "effective-margin-bottom"


effectiveMarginLeft : String -> Attribute msg
effectiveMarginLeft =
    attribute "effective-margin-left"


effectiveMarginRight : String -> Attribute msg
effectiveMarginRight =
    attribute "effective-margin-right"


effectiveMarginTop : String -> Attribute msg
effectiveMarginTop =
    attribute "effective-margin-top"


effectiveMinHeight : String -> Attribute msg
effectiveMinHeight =
    attribute "effective-min-height"


effectiveMinWidth : String -> Attribute msg
effectiveMinWidth =
    attribute "effective-min-width"


effectivePaddingBottom : String -> Attribute msg
effectivePaddingBottom =
    attribute "effective-padding-bottom"


effectivePaddingLeft : String -> Attribute msg
effectivePaddingLeft =
    attribute "effective-padding-left"


effectivePaddingRight : String -> Attribute msg
effectivePaddingRight =
    attribute "effective-padding-right"


effectivePaddingTop : String -> Attribute msg
effectivePaddingTop =
    attribute "effective-padding-top"


effectiveTop : String -> Attribute msg
effectiveTop =
    attribute "effective-top"


effectiveWidth : String -> Attribute msg
effectiveWidth =
    attribute "effective-width"


flexGrow : String -> Attribute msg
flexGrow =
    attribute "flex-grow"


flexShrink : String -> Attribute msg
flexShrink =
    attribute "flex-shrink"


flexWrapBefore : String -> Attribute msg
flexWrapBefore =
    attribute "flex-wrap-before"


height : String -> Attribute msg
height =
    attribute "height"


horizontalAlignment : String -> Attribute msg
horizontalAlignment =
    attribute "horizontal-alignment"


id : String -> Attribute msg
id =
    attribute "id"


itemId : String -> Attribute msg
itemId =
    attribute "item-id"


iosIgnoreSafeArea : String -> Attribute msg
iosIgnoreSafeArea =
    attribute "ios-ignore-safe-area"


iosOverflowSafeArea : String -> Attribute msg
iosOverflowSafeArea =
    attribute "ios-overflow-safe-area"


iosOverflowSafeAreaEnabled : String -> Attribute msg
iosOverflowSafeAreaEnabled =
    attribute "ios-overflow-safe-area-enabled"


isCollapsed : String -> Attribute msg
isCollapsed =
    attribute "is-collapsed"


isEnabled : String -> Attribute msg
isEnabled =
    attribute "is-enabled"


isLayoutRequired : String -> Attribute msg
isLayoutRequired =
    attribute "is-layout-required"


isLayoutValid : String -> Attribute msg
isLayoutValid =
    attribute "is-layout-valid"


isUserInteractionEnabled : String -> Attribute msg
isUserInteractionEnabled =
    attribute "is-user-interaction-enabled"


left : String -> Attribute msg
left =
    attribute "left"


margin : String -> Attribute msg
margin =
    attribute "margin"


marginBottom : String -> Attribute msg
marginBottom =
    attribute "margin-bottom"


marginLeft : String -> Attribute msg
marginLeft =
    attribute "margin-left"


marginRight : String -> Attribute msg
marginRight =
    attribute "margin-right"


marginTop : String -> Attribute msg
marginTop =
    attribute "margin-top"


minHeight : String -> Attribute msg
minHeight =
    attribute "min-height"


minWidth : String -> Attribute msg
minWidth =
    attribute "min-width"


nativeViewProtected : String -> Attribute msg
nativeViewProtected =
    attribute "native-view-protected"


opacity : String -> Attribute msg
opacity =
    attribute "opacity"


order : String -> Attribute msg
order =
    attribute "order"


originX : String -> Attribute msg
originX =
    attribute "origin-x"


originY : String -> Attribute msg
originY =
    attribute "origin-y"


perspective : String -> Attribute msg
perspective =
    attribute "perspective"


recycleNativeView : String -> Attribute msg
recycleNativeView =
    attribute "recycle-native-view"


reusable : String -> Attribute msg
reusable =
    attribute "reusable"


rotate : String -> Attribute msg
rotate =
    attribute "rotate"


rotateX : String -> Attribute msg
rotateX =
    attribute "rotate-x"


rotateY : String -> Attribute msg
rotateY =
    attribute "rotate-y"


row : String -> Attribute msg
row =
    attribute "row"


busy : String -> Attribute msg
busy =
    attribute "busy"


rows : String -> Attribute msg
rows =
    attribute "rows"


rowSpan : String -> Attribute msg
rowSpan =
    attribute "row-span"


scaleX : String -> Attribute msg
scaleX =
    attribute "scale-x"


scaleY : String -> Attribute msg
scaleY =
    attribute "scale-y"


top : String -> Attribute msg
top =
    attribute "top"


translateX : String -> Attribute msg
translateX =
    attribute "translate-x"


translateY : String -> Attribute msg
translateY =
    attribute "translate-y"


textWrap : String -> Attribute msg
textWrap =
    attribute "text-wrap"


verticalAlignment : String -> Attribute msg
verticalAlignment =
    attribute "vertical-alignment"


viewController : String -> Attribute msg
viewController =
    attribute "view-controller"


visibility : String -> Attribute msg
visibility =
    attribute "visibility"


width : String -> Attribute msg
width =
    attribute "width"


actionBarVisibility : String -> Attribute msg
actionBarVisibility =
    attribute "action-bar-visibility"


animated : String -> Attribute msg
animated =
    attribute "animated"


transition : String -> Attribute msg
transition =
    attribute "transition"


defaultAnimatedNavigation : String -> Attribute msg
defaultAnimatedNavigation =
    attribute "default-animated-navigation"


defaultTransition : String -> Attribute msg
defaultTransition =
    attribute "default-transition"


accessibilityAnnouncePageEnabled : String -> Attribute msg
accessibilityAnnouncePageEnabled =
    attribute "accessibility-announce-page-enabled"


actionBarHidden : String -> Attribute msg
actionBarHidden =
    attribute "action-bar-hidden"


androidStatusBarBackground : String -> Attribute msg
androidStatusBarBackground =
    attribute "android-status-bar-background"


backgroundSpanUnderStatusBar : String -> Attribute msg
backgroundSpanUnderStatusBar =
    attribute "background-span-under-status-bar"


enableSwipeBackNavigation : String -> Attribute msg
enableSwipeBackNavigation =
    attribute "enable-swipe-back-navigation"


statusBarStyle : String -> Attribute msg
statusBarStyle =
    attribute "status-bar-style"


date : String -> Attribute msg
date =
    attribute "date"


iosPreferredDatePickerStyle : String -> Attribute msg
iosPreferredDatePickerStyle =
    attribute "ios-preferred-date-picker-style"


maxDate : String -> Attribute msg
maxDate =
    attribute "max-date"


minDate : String -> Attribute msg
minDate =
    attribute "min-date"


day : String -> Attribute msg
day =
    attribute "day"


month : String -> Attribute msg
month =
    attribute "month"


year : String -> Attribute msg
year =
    attribute "year"


html : String -> Attribute msg
html =
    attribute "html"


decodeHeight : String -> Attribute msg
decodeHeight =
    attribute "decode-height"


decodeWidth : String -> Attribute msg
decodeWidth =
    attribute "decode-width"


isLoading : String -> Attribute msg
isLoading =
    attribute "is-loading"


loadMode : String -> Attribute msg
loadMode =
    attribute "load-mode"


src : String -> Attribute msg
src =
    attribute "src"


stretch : String -> Attribute msg
stretch =
    attribute "stretch"


tintColor : String -> Attribute msg
tintColor =
    attribute "tint-color"


selectedIndex : String -> Attribute msg
selectedIndex =
    attribute "selected-index"


maxValue : String -> Attribute msg
maxValue =
    attribute "max-value"


value : String -> Attribute msg
value =
    attribute "value"


checked : String -> Attribute msg
checked =
    attribute "checked"


minValue : String -> Attribute msg
minValue =
    attribute "min-value"


horizontalOffset : String -> Attribute msg
horizontalOffset =
    attribute "horizontal-offset"


isScrollEnabled : String -> Attribute msg
isScrollEnabled =
    attribute "is-scroll-enabled"


scrollBarIndicatorVisible : String -> Attribute msg
scrollBarIndicatorVisible =
    attribute "scroll-bar-indicator-visible"


scrollableHeight : String -> Attribute msg
scrollableHeight =
    attribute "scrollable-height"


scrollableWidth : String -> Attribute msg
scrollableWidth =
    attribute "scrollable-width"


verticalOffset : String -> Attribute msg
verticalOffset =
    attribute "vertical-offset"


hint : String -> Attribute msg
hint =
    attribute "hint"


textFieldBackgroundColor : String -> Attribute msg
textFieldBackgroundColor =
    attribute "text-field-background-color"


textFieldHintColor : String -> Attribute msg
textFieldHintColor =
    attribute "text-field-hint-color"


title : String -> Attribute msg
title =
    attribute "title"


flat : String -> Attribute msg
flat =
    attribute "flat"


titleView : String -> Attribute msg
titleView =
    attribute "title-view"


selectedBackgroundColor : String -> Attribute msg
selectedBackgroundColor =
    attribute "selected-background-color"


androidOffscreenTabLimit : String -> Attribute msg
androidOffscreenTabLimit =
    attribute "android-offscreen-tab-limit"


androidSelectedTabHighlightColor : String -> Attribute msg
androidSelectedTabHighlightColor =
    attribute "android-selected-tab-highlight-color"


androidSwipeEnabled : String -> Attribute msg
androidSwipeEnabled =
    attribute "android-swipe-enabled"


androidTabsPosition : String -> Attribute msg
androidTabsPosition =
    attribute "android-tabs-position"


iosIconRenderingMode : String -> Attribute msg
iosIconRenderingMode =
    attribute "ios-icon-rendering-mode"


selectedTabTextColor : String -> Attribute msg
selectedTabTextColor =
    attribute "selected-tab-text-color"


tabBackgroundColor : String -> Attribute msg
tabBackgroundColor =
    attribute "tab-background-color"


tabTextColor : String -> Attribute msg
tabTextColor =
    attribute "tab-text-color"


tabTextFontSize : String -> Attribute msg
tabTextFontSize =
    attribute "tab-text-font-size"


canBeLoaded : String -> Attribute msg
canBeLoaded =
    attribute "can-be-loaded"


canGoBack : String -> Attribute msg
canGoBack =
    attribute "can-go-back"


canGoForward : String -> Attribute msg
canGoForward =
    attribute "can-go-forward"


iconSource : String -> Attribute msg
iconSource =
    attribute "icon-source"


autocapitalizationType : String -> Attribute msg
autocapitalizationType =
    attribute "autocapitalization-type"


autocorrect : String -> Attribute msg
autocorrect =
    attribute "autocorrect"


autofillType : String -> Attribute msg
autofillType =
    attribute "autofill-type"


closeOnReturn : String -> Attribute msg
closeOnReturn =
    attribute "close-on-return"


editable : String -> Attribute msg
editable =
    attribute "editable"


keyboardType : String -> Attribute msg
keyboardType =
    attribute "keyboard-type"


maxLength : String -> Attribute msg
maxLength =
    attribute "max-length"


returnKeyType : String -> Attribute msg
returnKeyType =
    attribute "return-key-type"


secure : String -> Attribute msg
secure =
    attribute "secure"


secureWithoutAutofill : String -> Attribute msg
secureWithoutAutofill =
    attribute "secure-without-autofill"


updateTextTrigger : String -> Attribute msg
updateTextTrigger =
    attribute "update-text-trigger"


maxLines : String -> Attribute msg
maxLines =
    attribute "max-lines"


hour : String -> Attribute msg
hour =
    attribute "hour"


maxHour : String -> Attribute msg
maxHour =
    attribute "max-hour"


maxMinute : String -> Attribute msg
maxMinute =
    attribute "max-minute"


minHour : String -> Attribute msg
minHour =
    attribute "min-hour"


minMinute : String -> Attribute msg
minMinute =
    attribute "min-minute"


minute : String -> Attribute msg
minute =
    attribute "minute"


minuteInterval : String -> Attribute msg
minuteInterval =
    attribute "minute-interval"


time : String -> Attribute msg
time =
    attribute "time"


iosPosition : String -> Attribute msg
iosPosition =
    attribute "ios.position"


androidPosition : String -> Attribute msg
androidPosition =
    attribute "android.position"


iosSystemIcon : String -> Attribute msg
iosSystemIcon =
    attribute "ios.system-icon"


androidSystemIcon : String -> Attribute msg
androidSystemIcon =
    attribute "android.system-icon"


iosEstimatedRowHeight : String -> Attribute msg
iosEstimatedRowHeight =
    attribute "ios-estimated-row-height"


rowHeight : String -> Attribute msg
rowHeight =
    attribute "row-height"


separatorColor : String -> Attribute msg
separatorColor =
    attribute "separator-color"


fontFamily : String -> Attribute msg
fontFamily =
    attribute "font-family"


{-| Caution: This allows execution of JS.
Ensure your string is generated at compile time and NOT dynamic

Good usage:

    itemTemplateSelector <|
        dangerousEvalExpression " $value % 2 == 0 ? 'template1' : 'template2'"

    dangerousEvalExpression " isIOS ? UITableViewCellSelectionStyle.None : 0 "

BAD usage:

    dangerousEvalExpression (" $value % " ++ user.input ++ " == 0")

-}
dangerousEvalExpression : String -> String
dangerousEvalExpression expression =
    "e{" ++ expression ++ "}"


{-| Binding expressions are supported only when ListView is their ancestor.
In any other case, there won't we any value to bind to. So it will be empty
-}
bindAttributeWithExpression : String -> String -> Attribute msg
bindAttributeWithExpression attributeName expression =
    attribute ("bind-" ++ attributeName) ("b{" ++ expression ++ "}")


ios : String -> String -> Attribute msg
ios propertyName propertyValue =
    attribute "ios" (propertyName ++ ";" ++ propertyValue)


android : String -> String -> Attribute msg
android propertyName propertyValue =
    attribute "android" (propertyName ++ ";" ++ propertyValue)


modalConfig : Bool -> Attribute msg
modalConfig isFullScreenModal =
    property "modalPage" (E.bool isFullScreenModal)


items : ListViewModel a -> Attribute msg
items listViewModel =
    property "items" (Native.getEncodedItems listViewModel)
