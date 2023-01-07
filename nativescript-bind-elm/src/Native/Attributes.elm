module Native.Attributes exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (attribute)


fontSize : String -> Attribute msg
fontSize =
    attribute "font-size"


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


bindingContext : String -> Attribute msg
bindingContext =
    attribute "binding-context"


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


className : String -> Attribute msg
className =
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


modal : String -> Attribute msg
modal =
    attribute "modal"


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


parent : String -> Attribute msg
parent =
    attribute "parent"


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
