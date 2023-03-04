module Native.Attributes exposing
    ( dangerousEvalExpression, bindAttributeWithExpression
    , ios, android
    , modalConfig, items
    , fontSize
    , fontWeight
    , fontStyle
    , formattedText
    , letterSpacing
    , lineHeight
    , nativeTextViewProtected
    , text
    , key
    , icon
    , style
    , textAlignment
    , textDecoration
    , textShadow
    , textTransform
    , whiteSpace
    , stretchLastChild
    , orientation
    , itemHeight
    , itemWidth
    , alignContent
    , alignItems
    , flexDirection
    , flexWrap
    , justifyContent
    , padding
    , paddingBottom
    , paddingLeft
    , paddingRight
    , paddingTop
    , accessibilityHidden
    , accessibilityHint
    , accessibilityIdentifier
    , accessibilityLabel
    , accessibilityLanguage
    , accessibilityLiveRegion
    , accessibilityMediaSession
    , accessibilityRole
    , accessibilityState
    , accessibilityValue
    , accessible
    , alignSelf
    , androidDynamicElevationOffset
    , androidElevation
    , automationText
    , background
    , backgroundColor
    , backgroundImage
    , borderBottomColor
    , borderBottomLeftRadius
    , borderBottomRightRadius
    , borderBottomWidth
    , borderColor
    , borderLeftColor
    , borderLeftWidth
    , borderRadius
    , borderRightColor
    , borderRightWidth
    , borderTopColor
    , borderTopLeftRadius
    , borderTopRightRadius
    , borderTopWidth
    , borderWidth
    , boxShadow
    , class
    , col
    , colSpan
    , color
    , column
    , columns
    , columnSpan
    , css
    , cssClasses
    , cssPseudoClasses
    , cssType
    , dock
    , domNode
    , effectiveBorderBottomWidth
    , effectiveBorderLeftWidth
    , effectiveBorderRightWidth
    , effectiveBorderTopWidth
    , effectiveHeight
    , effectiveLeft
    , effectiveMarginBottom
    , effectiveMarginLeft
    , effectiveMarginRight
    , effectiveMarginTop
    , effectiveMinHeight
    , effectiveMinWidth
    , effectivePaddingBottom
    , effectivePaddingLeft
    , effectivePaddingRight
    , effectivePaddingTop
    , effectiveTop
    , effectiveWidth
    , flexGrow
    , flexShrink
    , flexWrapBefore
    , height
    , horizontalAlignment
    , id
    , itemId
    , iosIgnoreSafeArea
    , iosOverflowSafeArea
    , iosOverflowSafeAreaEnabled
    , isCollapsed
    , isEnabled
    , isLayoutRequired
    , isLayoutValid
    , isUserInteractionEnabled
    , left
    , margin
    , marginBottom
    , marginLeft
    , marginRight
    , marginTop
    , minHeight
    , minWidth
    , nativeViewProtected
    , opacity
    , order
    , originX
    , originY
    , perspective
    , recycleNativeView
    , reusable
    , rotate
    , rotateX
    , rotateY
    , row
    , busy
    , rows
    , rowSpan
    , scaleX
    , scaleY
    , top
    , translateX
    , translateY
    , textWrap
    , verticalAlignment
    , viewController
    , visibility
    , width
    , actionBarVisibility
    , animated
    , transition
    , defaultAnimatedNavigation
    , defaultTransition
    , accessibilityAnnouncePageEnabled
    , actionBarHidden
    , androidStatusBarBackground
    , backgroundSpanUnderStatusBar
    , enableSwipeBackNavigation
    , statusBarStyle
    , date
    , iosPreferredDatePickerStyle
    , maxDate
    , minDate
    , day
    , month
    , year
    , html
    , decodeHeight
    , decodeWidth
    , isLoading
    , loadMode
    , src
    , stretch
    , tintColor
    , selectedIndex
    , maxValue
    , value
    , checked
    , minValue
    , horizontalOffset
    , isScrollEnabled
    , scrollBarIndicatorVisible
    , scrollableHeight
    , scrollableWidth
    , verticalOffset
    , hint
    , textFieldBackgroundColor
    , textFieldHintColor
    , title
    , flat
    , titleView
    , selectedBackgroundColor
    , androidOffscreenTabLimit
    , androidSelectedTabHighlightColor
    , androidSwipeEnabled
    , androidTabsPosition
    , iosIconRenderingMode
    , selectedTabTextColor
    , tabBackgroundColor
    , tabTextColor
    , tabTextFontSize
    , canBeLoaded
    , canGoBack
    , canGoForward
    , iconSource
    , autocapitalizationType
    , autocorrect
    , autofillType
    , closeOnReturn
    , editable
    , keyboardType
    , maxLength
    , returnKeyType
    , secure
    , secureWithoutAutofill
    , updateTextTrigger
    , maxLines
    , hour
    , maxHour
    , maxMinute
    , minHour
    , minMinute
    , minute
    , minuteInterval
    , time
    , iosPosition
    , androidPosition
    , iosSystemIcon
    , androidSystemIcon
    , iosEstimatedRowHeight
    , rowHeight
    , separatorColor
    , fontFamily
    )

{-| Nativescript element attributes


# Attributes

@docs dangerousEvalExpression, bindAttributeWithExpression
@docs ios, android
@docs modalConfig, items

@docs fontSize
@docs fontWeight
@docs fontStyle
@docs formattedText
@docs letterSpacing
@docs lineHeight
@docs nativeTextViewProtected
@docs text
@docs key
@docs icon
@docs style
@docs textAlignment
@docs textDecoration
@docs textShadow
@docs textTransform
@docs whiteSpace
@docs stretchLastChild
@docs orientation
@docs itemHeight
@docs itemWidth
@docs alignContent
@docs alignItems
@docs flexDirection
@docs flexWrap
@docs justifyContent
@docs padding
@docs paddingBottom
@docs paddingLeft
@docs paddingRight
@docs paddingTop
@docs accessibilityHidden
@docs accessibilityHint
@docs accessibilityIdentifier
@docs accessibilityLabel
@docs accessibilityLanguage
@docs accessibilityLiveRegion
@docs accessibilityMediaSession
@docs accessibilityRole
@docs accessibilityState
@docs accessibilityValue
@docs accessible
@docs alignSelf
@docs androidDynamicElevationOffset
@docs androidElevation
@docs automationText
@docs background
@docs backgroundColor
@docs backgroundImage
@docs borderBottomColor
@docs borderBottomLeftRadius
@docs borderBottomRightRadius
@docs borderBottomWidth
@docs borderColor
@docs borderLeftColor
@docs borderLeftWidth
@docs borderRadius
@docs borderRightColor
@docs borderRightWidth
@docs borderTopColor
@docs borderTopLeftRadius
@docs borderTopRightRadius
@docs borderTopWidth
@docs borderWidth
@docs boxShadow
@docs class
@docs col
@docs colSpan
@docs color
@docs column
@docs columns
@docs columnSpan
@docs css
@docs cssClasses
@docs cssPseudoClasses
@docs cssType
@docs dock
@docs domNode
@docs effectiveBorderBottomWidth
@docs effectiveBorderLeftWidth
@docs effectiveBorderRightWidth
@docs effectiveBorderTopWidth
@docs effectiveHeight
@docs effectiveLeft
@docs effectiveMarginBottom
@docs effectiveMarginLeft
@docs effectiveMarginRight
@docs effectiveMarginTop
@docs effectiveMinHeight
@docs effectiveMinWidth
@docs effectivePaddingBottom
@docs effectivePaddingLeft
@docs effectivePaddingRight
@docs effectivePaddingTop
@docs effectiveTop
@docs effectiveWidth
@docs flexGrow
@docs flexShrink
@docs flexWrapBefore
@docs height
@docs horizontalAlignment
@docs id
@docs itemId
@docs iosIgnoreSafeArea
@docs iosOverflowSafeArea
@docs iosOverflowSafeAreaEnabled
@docs isCollapsed
@docs isEnabled
@docs isLayoutRequired
@docs isLayoutValid
@docs isUserInteractionEnabled
@docs left
@docs margin
@docs marginBottom
@docs marginLeft
@docs marginRight
@docs marginTop
@docs minHeight
@docs minWidth
@docs nativeViewProtected
@docs opacity
@docs order
@docs originX
@docs originY
@docs perspective
@docs recycleNativeView
@docs reusable
@docs rotate
@docs rotateX
@docs rotateY
@docs row
@docs busy
@docs rows
@docs rowSpan
@docs scaleX
@docs scaleY
@docs top
@docs translateX
@docs translateY
@docs textWrap
@docs verticalAlignment
@docs viewController
@docs visibility
@docs width
@docs actionBarVisibility
@docs animated
@docs transition
@docs defaultAnimatedNavigation
@docs defaultTransition
@docs accessibilityAnnouncePageEnabled
@docs actionBarHidden
@docs androidStatusBarBackground
@docs backgroundSpanUnderStatusBar
@docs enableSwipeBackNavigation
@docs statusBarStyle
@docs date
@docs iosPreferredDatePickerStyle
@docs maxDate
@docs minDate
@docs day
@docs month
@docs year
@docs html
@docs decodeHeight
@docs decodeWidth
@docs isLoading
@docs loadMode
@docs src
@docs stretch
@docs tintColor
@docs selectedIndex
@docs maxValue
@docs value
@docs checked
@docs minValue
@docs horizontalOffset
@docs isScrollEnabled
@docs scrollBarIndicatorVisible
@docs scrollableHeight
@docs scrollableWidth
@docs verticalOffset
@docs hint
@docs textFieldBackgroundColor
@docs textFieldHintColor
@docs title
@docs flat
@docs titleView
@docs selectedBackgroundColor
@docs androidOffscreenTabLimit
@docs androidSelectedTabHighlightColor
@docs androidSwipeEnabled
@docs androidTabsPosition
@docs iosIconRenderingMode
@docs selectedTabTextColor
@docs tabBackgroundColor
@docs tabTextColor
@docs tabTextFontSize
@docs canBeLoaded
@docs canGoBack
@docs canGoForward
@docs iconSource
@docs autocapitalizationType
@docs autocorrect
@docs autofillType
@docs closeOnReturn
@docs editable
@docs keyboardType
@docs maxLength
@docs returnKeyType
@docs secure
@docs secureWithoutAutofill
@docs updateTextTrigger
@docs maxLines
@docs hour
@docs maxHour
@docs maxMinute
@docs minHour
@docs minMinute
@docs minute
@docs minuteInterval
@docs time
@docs iosPosition
@docs androidPosition
@docs iosSystemIcon
@docs androidSystemIcon
@docs iosEstimatedRowHeight
@docs rowHeight
@docs separatorColor
@docs fontFamily

-}

import Html exposing (Attribute)
import Html.Attributes exposing (attribute, property)
import Json.Encode as E
import Native exposing (ListViewModel)


{-| Sets fontSize
-}
fontSize : String -> Attribute msg
fontSize =
    attribute "font-size"


{-| Sets fontWeight
-}
fontWeight : String -> Attribute msg
fontWeight =
    attribute "font-weight"


{-| Sets fontStyle
-}
fontStyle : String -> Attribute msg
fontStyle =
    attribute "font-style"


{-| Sets formattedText
-}
formattedText : String -> Attribute msg
formattedText =
    attribute "formatted-text"


{-| Sets letterSpacing
-}
letterSpacing : String -> Attribute msg
letterSpacing =
    attribute "letter-spacing"


{-| Sets lineHeight
-}
lineHeight : String -> Attribute msg
lineHeight =
    attribute "line-height"


{-| Sets nativeTextViewProtected
-}
nativeTextViewProtected : String -> Attribute msg
nativeTextViewProtected =
    attribute "native-text-view-protected"


{-| Sets text
-}
text : String -> Attribute msg
text =
    attribute "text"


{-| Sets key
-}
key : String -> Attribute msg
key =
    attribute "key"


{-| Sets icon
-}
icon : String -> Attribute msg
icon =
    attribute "icon"


{-| Sets style
-}
style : String -> Attribute msg
style =
    attribute "style"


{-| Sets textAlignment
-}
textAlignment : String -> Attribute msg
textAlignment =
    attribute "text-alignment"


{-| Sets textDecoration
-}
textDecoration : String -> Attribute msg
textDecoration =
    attribute "text-decoration"


{-| Sets textShadow
-}
textShadow : String -> Attribute msg
textShadow =
    attribute "text-shadow"


{-| Sets textTransform
-}
textTransform : String -> Attribute msg
textTransform =
    attribute "text-transform"


{-| Sets whiteSpace
-}
whiteSpace : String -> Attribute msg
whiteSpace =
    attribute "white-space"


{-| Sets stretchLastChild
-}
stretchLastChild : String -> Attribute msg
stretchLastChild =
    attribute "stretch-last-child"


{-| Sets orientation
-}
orientation : String -> Attribute msg
orientation =
    attribute "orientation"


{-| Sets itemHeight
-}
itemHeight : String -> Attribute msg
itemHeight =
    attribute "item-height"


{-| Sets itemWidth
-}
itemWidth : String -> Attribute msg
itemWidth =
    attribute "item-width"


{-| Sets alignContent
-}
alignContent : String -> Attribute msg
alignContent =
    attribute "align-content"


{-| Sets alignItems
-}
alignItems : String -> Attribute msg
alignItems =
    attribute "align-items"


{-| Sets flexDirection
-}
flexDirection : String -> Attribute msg
flexDirection =
    attribute "flex-direction"


{-| Sets flexWrap
-}
flexWrap : String -> Attribute msg
flexWrap =
    attribute "flex-wrap"


{-| Sets justifyContent
-}
justifyContent : String -> Attribute msg
justifyContent =
    attribute "justify-content"


{-| Sets padding
-}
padding : String -> Attribute msg
padding =
    attribute "padding"


{-| Sets paddingBottom
-}
paddingBottom : String -> Attribute msg
paddingBottom =
    attribute "padding-bottom"


{-| Sets paddingLeft
-}
paddingLeft : String -> Attribute msg
paddingLeft =
    attribute "padding-left"


{-| Sets paddingRight
-}
paddingRight : String -> Attribute msg
paddingRight =
    attribute "padding-right"


{-| Sets paddingTop
-}
paddingTop : String -> Attribute msg
paddingTop =
    attribute "padding-top"


{-| Sets accessibilityHidden
-}
accessibilityHidden : String -> Attribute msg
accessibilityHidden =
    attribute "accessibility-hidden"


{-| Sets accessibilityHint
-}
accessibilityHint : String -> Attribute msg
accessibilityHint =
    attribute "accessibility-hint"


{-| Sets accessibilityIdentifier
-}
accessibilityIdentifier : String -> Attribute msg
accessibilityIdentifier =
    attribute "accessibility-identifier"


{-| Sets accessibilityLabel
-}
accessibilityLabel : String -> Attribute msg
accessibilityLabel =
    attribute "accessibility-label"


{-| Sets accessibilityLanguage
-}
accessibilityLanguage : String -> Attribute msg
accessibilityLanguage =
    attribute "accessibility-language"


{-| Sets accessibilityLiveRegion
-}
accessibilityLiveRegion : String -> Attribute msg
accessibilityLiveRegion =
    attribute "accessibility-live-region"


{-| Sets accessibilityMediaSession
-}
accessibilityMediaSession : String -> Attribute msg
accessibilityMediaSession =
    attribute "accessibility-media-session"


{-| Sets accessibilityRole
-}
accessibilityRole : String -> Attribute msg
accessibilityRole =
    attribute "accessibility-role"


{-| Sets accessibilityState
-}
accessibilityState : String -> Attribute msg
accessibilityState =
    attribute "accessibility-state"


{-| Sets accessibilityValue
-}
accessibilityValue : String -> Attribute msg
accessibilityValue =
    attribute "accessibility-value"


{-| Sets accessible
-}
accessible : String -> Attribute msg
accessible =
    attribute "accessible"


{-| Sets alignSelf
-}
alignSelf : String -> Attribute msg
alignSelf =
    attribute "align-self"


{-| Sets androidDynamicElevationOffset
-}
androidDynamicElevationOffset : String -> Attribute msg
androidDynamicElevationOffset =
    attribute "android-dynamic-elevation-offset"


{-| Sets androidElevation
-}
androidElevation : String -> Attribute msg
androidElevation =
    attribute "android-elevation"


{-| Sets automationText
-}
automationText : String -> Attribute msg
automationText =
    attribute "automation-text"


{-| Sets background
-}
background : String -> Attribute msg
background =
    attribute "background"


{-| Sets backgroundColor
-}
backgroundColor : String -> Attribute msg
backgroundColor =
    attribute "background-color"


{-| Sets backgroundImage
-}
backgroundImage : String -> Attribute msg
backgroundImage =
    attribute "background-image"


{-| Sets borderBottomColor
-}
borderBottomColor : String -> Attribute msg
borderBottomColor =
    attribute "border-bottom-color"


{-| Sets borderBottomLeftRadius
-}
borderBottomLeftRadius : String -> Attribute msg
borderBottomLeftRadius =
    attribute "border-bottom-left-radius"


{-| Sets borderBottomRightRadius
-}
borderBottomRightRadius : String -> Attribute msg
borderBottomRightRadius =
    attribute "border-bottom-right-radius"


{-| Sets borderBottomWidth
-}
borderBottomWidth : String -> Attribute msg
borderBottomWidth =
    attribute "border-bottom-width"


{-| Sets borderColor
-}
borderColor : String -> Attribute msg
borderColor =
    attribute "border-color"


{-| Sets borderLeftColor
-}
borderLeftColor : String -> Attribute msg
borderLeftColor =
    attribute "border-left-color"


{-| Sets borderLeftWidth
-}
borderLeftWidth : String -> Attribute msg
borderLeftWidth =
    attribute "border-left-width"


{-| Sets borderRadius
-}
borderRadius : String -> Attribute msg
borderRadius =
    attribute "border-radius"


{-| Sets borderRightColor
-}
borderRightColor : String -> Attribute msg
borderRightColor =
    attribute "border-right-color"


{-| Sets borderRightWidth
-}
borderRightWidth : String -> Attribute msg
borderRightWidth =
    attribute "border-right-width"


{-| Sets borderTopColor
-}
borderTopColor : String -> Attribute msg
borderTopColor =
    attribute "border-top-color"


{-| Sets borderTopLeftRadius
-}
borderTopLeftRadius : String -> Attribute msg
borderTopLeftRadius =
    attribute "border-top-left-radius"


{-| Sets borderTopRightRadius
-}
borderTopRightRadius : String -> Attribute msg
borderTopRightRadius =
    attribute "border-top-right-radius"


{-| Sets borderTopWidth
-}
borderTopWidth : String -> Attribute msg
borderTopWidth =
    attribute "border-top-width"


{-| Sets borderWidth
-}
borderWidth : String -> Attribute msg
borderWidth =
    attribute "border-width"


{-| Sets boxShadow
-}
boxShadow : String -> Attribute msg
boxShadow =
    attribute "box-shadow"


{-| Sets class
-}
class : String -> Attribute msg
class =
    attribute "class-name"


{-| Sets col
-}
col : String -> Attribute msg
col =
    attribute "col"


{-| Sets colSpan
-}
colSpan : String -> Attribute msg
colSpan =
    attribute "col-span"


{-| Sets color
-}
color : String -> Attribute msg
color =
    attribute "color"


{-| Sets column
-}
column : String -> Attribute msg
column =
    attribute "column"


{-| Sets columns
-}
columns : String -> Attribute msg
columns =
    attribute "columns"


{-| Sets columnSpan
-}
columnSpan : String -> Attribute msg
columnSpan =
    attribute "column-span"


{-| Sets css
-}
css : String -> Attribute msg
css =
    attribute "css"


{-| Sets cssClasses
-}
cssClasses : String -> Attribute msg
cssClasses =
    attribute "css-classes"


{-| Sets cssPseudoClasses
-}
cssPseudoClasses : String -> Attribute msg
cssPseudoClasses =
    attribute "css-pseudo-classes"


{-| Sets cssType
-}
cssType : String -> Attribute msg
cssType =
    attribute "css-type"


{-| Sets dock
-}
dock : String -> Attribute msg
dock =
    attribute "dock"


{-| Sets domNode
-}
domNode : String -> Attribute msg
domNode =
    attribute "dom-node"


{-| Sets effectiveBorderBottomWidth
-}
effectiveBorderBottomWidth : String -> Attribute msg
effectiveBorderBottomWidth =
    attribute "effective-border-bottom-width"


{-| Sets effectiveBorderLeftWidth
-}
effectiveBorderLeftWidth : String -> Attribute msg
effectiveBorderLeftWidth =
    attribute "effective-border-left-width"


{-| Sets effectiveBorderRightWidth
-}
effectiveBorderRightWidth : String -> Attribute msg
effectiveBorderRightWidth =
    attribute "effective-border-right-width"


{-| Sets effectiveBorderTopWidth
-}
effectiveBorderTopWidth : String -> Attribute msg
effectiveBorderTopWidth =
    attribute "effective-border-top-width"


{-| Sets effectiveHeight
-}
effectiveHeight : String -> Attribute msg
effectiveHeight =
    attribute "effective-height"


{-| Sets effectiveLeft
-}
effectiveLeft : String -> Attribute msg
effectiveLeft =
    attribute "effective-left"


{-| Sets effectiveMarginBottom
-}
effectiveMarginBottom : String -> Attribute msg
effectiveMarginBottom =
    attribute "effective-margin-bottom"


{-| Sets effectiveMarginLeft
-}
effectiveMarginLeft : String -> Attribute msg
effectiveMarginLeft =
    attribute "effective-margin-left"


{-| Sets effectiveMarginRight
-}
effectiveMarginRight : String -> Attribute msg
effectiveMarginRight =
    attribute "effective-margin-right"


{-| Sets effectiveMarginTop
-}
effectiveMarginTop : String -> Attribute msg
effectiveMarginTop =
    attribute "effective-margin-top"


{-| Sets effectiveMinHeight
-}
effectiveMinHeight : String -> Attribute msg
effectiveMinHeight =
    attribute "effective-min-height"


{-| Sets effectiveMinWidth
-}
effectiveMinWidth : String -> Attribute msg
effectiveMinWidth =
    attribute "effective-min-width"


{-| Sets effectivePaddingBottom
-}
effectivePaddingBottom : String -> Attribute msg
effectivePaddingBottom =
    attribute "effective-padding-bottom"


{-| Sets effectivePaddingLeft
-}
effectivePaddingLeft : String -> Attribute msg
effectivePaddingLeft =
    attribute "effective-padding-left"


{-| Sets effectivePaddingRight
-}
effectivePaddingRight : String -> Attribute msg
effectivePaddingRight =
    attribute "effective-padding-right"


{-| Sets effectivePaddingTop
-}
effectivePaddingTop : String -> Attribute msg
effectivePaddingTop =
    attribute "effective-padding-top"


{-| Sets effectiveTop
-}
effectiveTop : String -> Attribute msg
effectiveTop =
    attribute "effective-top"


{-| Sets effectiveWidth
-}
effectiveWidth : String -> Attribute msg
effectiveWidth =
    attribute "effective-width"


{-| Sets flexGrow
-}
flexGrow : String -> Attribute msg
flexGrow =
    attribute "flex-grow"


{-| Sets flexShrink
-}
flexShrink : String -> Attribute msg
flexShrink =
    attribute "flex-shrink"


{-| Sets flexWrapBefore
-}
flexWrapBefore : String -> Attribute msg
flexWrapBefore =
    attribute "flex-wrap-before"


{-| Sets height
-}
height : String -> Attribute msg
height =
    attribute "height"


{-| Sets horizontalAlignment
-}
horizontalAlignment : String -> Attribute msg
horizontalAlignment =
    attribute "horizontal-alignment"


{-| Sets id
-}
id : String -> Attribute msg
id =
    attribute "id"


{-| Sets itemId
-}
itemId : String -> Attribute msg
itemId =
    attribute "item-id"


{-| Sets iosIgnoreSafeArea
-}
iosIgnoreSafeArea : String -> Attribute msg
iosIgnoreSafeArea =
    attribute "ios-ignore-safe-area"


{-| Sets iosOverflowSafeArea
-}
iosOverflowSafeArea : String -> Attribute msg
iosOverflowSafeArea =
    attribute "ios-overflow-safe-area"


{-| Sets iosOverflowSafeAreaEnabled
-}
iosOverflowSafeAreaEnabled : String -> Attribute msg
iosOverflowSafeAreaEnabled =
    attribute "ios-overflow-safe-area-enabled"


{-| Sets isCollapsed
-}
isCollapsed : String -> Attribute msg
isCollapsed =
    attribute "is-collapsed"


{-| Sets isEnabled
-}
isEnabled : String -> Attribute msg
isEnabled =
    attribute "is-enabled"


{-| Sets isLayoutRequired
-}
isLayoutRequired : String -> Attribute msg
isLayoutRequired =
    attribute "is-layout-required"


{-| Sets isLayoutValid
-}
isLayoutValid : String -> Attribute msg
isLayoutValid =
    attribute "is-layout-valid"


{-| Sets isUserInteractionEnabled
-}
isUserInteractionEnabled : String -> Attribute msg
isUserInteractionEnabled =
    attribute "is-user-interaction-enabled"


{-| Sets left
-}
left : String -> Attribute msg
left =
    attribute "left"


{-| Sets margin
-}
margin : String -> Attribute msg
margin =
    attribute "margin"


{-| Sets marginBottom
-}
marginBottom : String -> Attribute msg
marginBottom =
    attribute "margin-bottom"


{-| Sets marginLeft
-}
marginLeft : String -> Attribute msg
marginLeft =
    attribute "margin-left"


{-| Sets marginRight
-}
marginRight : String -> Attribute msg
marginRight =
    attribute "margin-right"


{-| Sets marginTop
-}
marginTop : String -> Attribute msg
marginTop =
    attribute "margin-top"


{-| Sets minHeight
-}
minHeight : String -> Attribute msg
minHeight =
    attribute "min-height"


{-| Sets minWidth
-}
minWidth : String -> Attribute msg
minWidth =
    attribute "min-width"


{-| Sets nativeViewProtected
-}
nativeViewProtected : String -> Attribute msg
nativeViewProtected =
    attribute "native-view-protected"


{-| Sets opacity
-}
opacity : String -> Attribute msg
opacity =
    attribute "opacity"


{-| Sets order
-}
order : String -> Attribute msg
order =
    attribute "order"


{-| Sets originX
-}
originX : String -> Attribute msg
originX =
    attribute "origin-x"


{-| Sets originY
-}
originY : String -> Attribute msg
originY =
    attribute "origin-y"


{-| Sets perspective
-}
perspective : String -> Attribute msg
perspective =
    attribute "perspective"


{-| Sets recycleNativeView
-}
recycleNativeView : String -> Attribute msg
recycleNativeView =
    attribute "recycle-native-view"


{-| Sets reusable
-}
reusable : String -> Attribute msg
reusable =
    attribute "reusable"


{-| Sets rotate
-}
rotate : String -> Attribute msg
rotate =
    attribute "rotate"


{-| Sets rotateX
-}
rotateX : String -> Attribute msg
rotateX =
    attribute "rotate-x"


{-| Sets rotateY
-}
rotateY : String -> Attribute msg
rotateY =
    attribute "rotate-y"


{-| Sets row
-}
row : String -> Attribute msg
row =
    attribute "row"


{-| Sets busy
-}
busy : String -> Attribute msg
busy =
    attribute "busy"


{-| Sets rows
-}
rows : String -> Attribute msg
rows =
    attribute "rows"


{-| Sets rowSpan
-}
rowSpan : String -> Attribute msg
rowSpan =
    attribute "row-span"


{-| Sets scaleX
-}
scaleX : String -> Attribute msg
scaleX =
    attribute "scale-x"


{-| Sets scaleY
-}
scaleY : String -> Attribute msg
scaleY =
    attribute "scale-y"


{-| Sets top
-}
top : String -> Attribute msg
top =
    attribute "top"


{-| Sets translateX
-}
translateX : String -> Attribute msg
translateX =
    attribute "translate-x"


{-| Sets translateY
-}
translateY : String -> Attribute msg
translateY =
    attribute "translate-y"


{-| Sets textWrap
-}
textWrap : String -> Attribute msg
textWrap =
    attribute "text-wrap"


{-| Sets verticalAlignment
-}
verticalAlignment : String -> Attribute msg
verticalAlignment =
    attribute "vertical-alignment"


{-| Sets viewController
-}
viewController : String -> Attribute msg
viewController =
    attribute "view-controller"


{-| Sets visibility
-}
visibility : String -> Attribute msg
visibility =
    attribute "visibility"


{-| Sets width
-}
width : String -> Attribute msg
width =
    attribute "width"


{-| Sets actionBarVisibility
-}
actionBarVisibility : String -> Attribute msg
actionBarVisibility =
    attribute "action-bar-visibility"


{-| Sets animated
-}
animated : String -> Attribute msg
animated =
    attribute "animated"


{-| Sets transition
-}
transition : String -> Attribute msg
transition =
    attribute "transition"


{-| Sets defaultAnimatedNavigation
-}
defaultAnimatedNavigation : String -> Attribute msg
defaultAnimatedNavigation =
    attribute "default-animated-navigation"


{-| Sets defaultTransition
-}
defaultTransition : String -> Attribute msg
defaultTransition =
    attribute "default-transition"


{-| Sets accessibilityAnnouncePageEnabled
-}
accessibilityAnnouncePageEnabled : String -> Attribute msg
accessibilityAnnouncePageEnabled =
    attribute "accessibility-announce-page-enabled"


{-| Sets actionBarHidden
-}
actionBarHidden : String -> Attribute msg
actionBarHidden =
    attribute "action-bar-hidden"


{-| Sets androidStatusBarBackground
-}
androidStatusBarBackground : String -> Attribute msg
androidStatusBarBackground =
    attribute "android-status-bar-background"


{-| Sets backgroundSpanUnderStatusBar
-}
backgroundSpanUnderStatusBar : String -> Attribute msg
backgroundSpanUnderStatusBar =
    attribute "background-span-under-status-bar"


{-| Sets enableSwipeBackNavigation
-}
enableSwipeBackNavigation : String -> Attribute msg
enableSwipeBackNavigation =
    attribute "enable-swipe-back-navigation"


{-| Sets statusBarStyle
-}
statusBarStyle : String -> Attribute msg
statusBarStyle =
    attribute "status-bar-style"


{-| Sets date
-}
date : String -> Attribute msg
date =
    attribute "date"


{-| Sets iosPreferredDatePickerStyle
-}
iosPreferredDatePickerStyle : String -> Attribute msg
iosPreferredDatePickerStyle =
    attribute "ios-preferred-date-picker-style"


{-| Sets maxDate
-}
maxDate : String -> Attribute msg
maxDate =
    attribute "max-date"


{-| Sets minDate
-}
minDate : String -> Attribute msg
minDate =
    attribute "min-date"


{-| Sets day
-}
day : String -> Attribute msg
day =
    attribute "day"


{-| Sets month
-}
month : String -> Attribute msg
month =
    attribute "month"


{-| Sets year
-}
year : String -> Attribute msg
year =
    attribute "year"


{-| Sets html
-}
html : String -> Attribute msg
html =
    attribute "html"


{-| Sets decodeHeight
-}
decodeHeight : String -> Attribute msg
decodeHeight =
    attribute "decode-height"


{-| Sets decodeWidth
-}
decodeWidth : String -> Attribute msg
decodeWidth =
    attribute "decode-width"


{-| Sets isLoading
-}
isLoading : String -> Attribute msg
isLoading =
    attribute "is-loading"


{-| Sets loadMode
-}
loadMode : String -> Attribute msg
loadMode =
    attribute "load-mode"


{-| Sets src
-}
src : String -> Attribute msg
src =
    attribute "src"


{-| Sets stretch
-}
stretch : String -> Attribute msg
stretch =
    attribute "stretch"


{-| Sets tintColor
-}
tintColor : String -> Attribute msg
tintColor =
    attribute "tint-color"


{-| Sets selectedIndex
-}
selectedIndex : String -> Attribute msg
selectedIndex =
    attribute "selected-index"


{-| Sets maxValue
-}
maxValue : String -> Attribute msg
maxValue =
    attribute "max-value"


{-| Sets value
-}
value : String -> Attribute msg
value =
    attribute "value"


{-| Sets checked
-}
checked : String -> Attribute msg
checked =
    attribute "checked"


{-| Sets minValue
-}
minValue : String -> Attribute msg
minValue =
    attribute "min-value"


{-| Sets horizontalOffset
-}
horizontalOffset : String -> Attribute msg
horizontalOffset =
    attribute "horizontal-offset"


{-| Sets isScrollEnabled
-}
isScrollEnabled : String -> Attribute msg
isScrollEnabled =
    attribute "is-scroll-enabled"


{-| Sets scrollBarIndicatorVisible
-}
scrollBarIndicatorVisible : String -> Attribute msg
scrollBarIndicatorVisible =
    attribute "scroll-bar-indicator-visible"


{-| Sets scrollableHeight
-}
scrollableHeight : String -> Attribute msg
scrollableHeight =
    attribute "scrollable-height"


{-| Sets scrollableWidth
-}
scrollableWidth : String -> Attribute msg
scrollableWidth =
    attribute "scrollable-width"


{-| Sets verticalOffset
-}
verticalOffset : String -> Attribute msg
verticalOffset =
    attribute "vertical-offset"


{-| Sets hint
-}
hint : String -> Attribute msg
hint =
    attribute "hint"


{-| Sets textFieldBackgroundColor
-}
textFieldBackgroundColor : String -> Attribute msg
textFieldBackgroundColor =
    attribute "text-field-background-color"


{-| Sets textFieldHintColor
-}
textFieldHintColor : String -> Attribute msg
textFieldHintColor =
    attribute "text-field-hint-color"


{-| Sets title
-}
title : String -> Attribute msg
title =
    attribute "title"


{-| Sets flat
-}
flat : String -> Attribute msg
flat =
    attribute "flat"


{-| Sets titleView
-}
titleView : String -> Attribute msg
titleView =
    attribute "title-view"


{-| Sets selectedBackgroundColor
-}
selectedBackgroundColor : String -> Attribute msg
selectedBackgroundColor =
    attribute "selected-background-color"


{-| Sets androidOffscreenTabLimit
-}
androidOffscreenTabLimit : String -> Attribute msg
androidOffscreenTabLimit =
    attribute "android-offscreen-tab-limit"


{-| Sets androidSelectedTabHighlightColor
-}
androidSelectedTabHighlightColor : String -> Attribute msg
androidSelectedTabHighlightColor =
    attribute "android-selected-tab-highlight-color"


{-| Sets androidSwipeEnabled
-}
androidSwipeEnabled : String -> Attribute msg
androidSwipeEnabled =
    attribute "android-swipe-enabled"


{-| Sets androidTabsPosition
-}
androidTabsPosition : String -> Attribute msg
androidTabsPosition =
    attribute "android-tabs-position"


{-| Sets iosIconRenderingMode
-}
iosIconRenderingMode : String -> Attribute msg
iosIconRenderingMode =
    attribute "ios-icon-rendering-mode"


{-| Sets selectedTabTextColor
-}
selectedTabTextColor : String -> Attribute msg
selectedTabTextColor =
    attribute "selected-tab-text-color"


{-| Sets tabBackgroundColor
-}
tabBackgroundColor : String -> Attribute msg
tabBackgroundColor =
    attribute "tab-background-color"


{-| Sets tabTextColor
-}
tabTextColor : String -> Attribute msg
tabTextColor =
    attribute "tab-text-color"


{-| Sets tabTextFontSize
-}
tabTextFontSize : String -> Attribute msg
tabTextFontSize =
    attribute "tab-text-font-size"


{-| Sets canBeLoaded
-}
canBeLoaded : String -> Attribute msg
canBeLoaded =
    attribute "can-be-loaded"


{-| Sets canGoBack
-}
canGoBack : String -> Attribute msg
canGoBack =
    attribute "can-go-back"


{-| Sets canGoForward
-}
canGoForward : String -> Attribute msg
canGoForward =
    attribute "can-go-forward"


{-| Sets iconSource
-}
iconSource : String -> Attribute msg
iconSource =
    attribute "icon-source"


{-| Sets autocapitalizationType
-}
autocapitalizationType : String -> Attribute msg
autocapitalizationType =
    attribute "autocapitalization-type"


{-| Sets autocorrect
-}
autocorrect : String -> Attribute msg
autocorrect =
    attribute "autocorrect"


{-| Sets autofillType
-}
autofillType : String -> Attribute msg
autofillType =
    attribute "autofill-type"


{-| Sets closeOnReturn
-}
closeOnReturn : String -> Attribute msg
closeOnReturn =
    attribute "close-on-return"


{-| Sets editable
-}
editable : String -> Attribute msg
editable =
    attribute "editable"


{-| Sets keyboardType
-}
keyboardType : String -> Attribute msg
keyboardType =
    attribute "keyboard-type"


{-| Sets maxLength
-}
maxLength : String -> Attribute msg
maxLength =
    attribute "max-length"


{-| Sets returnKeyType
-}
returnKeyType : String -> Attribute msg
returnKeyType =
    attribute "return-key-type"


{-| Sets secure
-}
secure : String -> Attribute msg
secure =
    attribute "secure"


{-| Sets secureWithoutAutofill
-}
secureWithoutAutofill : String -> Attribute msg
secureWithoutAutofill =
    attribute "secure-without-autofill"


{-| Sets updateTextTrigger
-}
updateTextTrigger : String -> Attribute msg
updateTextTrigger =
    attribute "update-text-trigger"


{-| Sets maxLines
-}
maxLines : String -> Attribute msg
maxLines =
    attribute "max-lines"


{-| Sets hour
-}
hour : String -> Attribute msg
hour =
    attribute "hour"


{-| Sets maxHour
-}
maxHour : String -> Attribute msg
maxHour =
    attribute "max-hour"


{-| Sets maxMinute
-}
maxMinute : String -> Attribute msg
maxMinute =
    attribute "max-minute"


{-| Sets minHour
-}
minHour : String -> Attribute msg
minHour =
    attribute "min-hour"


{-| Sets minMinute
-}
minMinute : String -> Attribute msg
minMinute =
    attribute "min-minute"


{-| Sets minute
-}
minute : String -> Attribute msg
minute =
    attribute "minute"


{-| Sets minuteInterval
-}
minuteInterval : String -> Attribute msg
minuteInterval =
    attribute "minute-interval"


{-| Sets time
-}
time : String -> Attribute msg
time =
    attribute "time"


{-| Sets iosPosition
-}
iosPosition : String -> Attribute msg
iosPosition =
    attribute "ios.position"


{-| Sets androidPosition
-}
androidPosition : String -> Attribute msg
androidPosition =
    attribute "android.position"


{-| Sets iosSystemIcon
-}
iosSystemIcon : String -> Attribute msg
iosSystemIcon =
    attribute "ios.system-icon"


{-| Sets androidSystemIcon
-}
androidSystemIcon : String -> Attribute msg
androidSystemIcon =
    attribute "android.system-icon"


{-| Sets iosEstimatedRowHeight
-}
iosEstimatedRowHeight : String -> Attribute msg
iosEstimatedRowHeight =
    attribute "ios-estimated-row-height"


{-| Sets rowHeight
-}
rowHeight : String -> Attribute msg
rowHeight =
    attribute "row-height"


{-| Sets separatorColor of listView
-}
separatorColor : String -> Attribute msg
separatorColor =
    attribute "separator-color"


{-| Sets fontFamily to element
-}
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
In any other case, there won't be any value to bind to. So it will be empty.

Use hypens instead of camelcase like `font-family` and not `fontFamily`

-}
bindAttributeWithExpression : String -> String -> Attribute msg
bindAttributeWithExpression attributeName expression =
    attribute ("bind-" ++ attributeName) ("b{" ++ expression ++ "}")


{-| Allows setting iOS only attributes. The attribute is set only when the mobile OS is iOS
-}
ios : String -> String -> Attribute msg
ios propertyName propertyValue =
    attribute "ios" (propertyName ++ ";" ++ propertyValue)


{-| Allows setting android only attributes. The attribute is set only when the mobile OS is android
-}
android : String -> String -> Attribute msg
android propertyName propertyValue =
    attribute "android" (propertyName ++ ";" ++ propertyValue)


{-| Used to show a page as modal and no backstack is added
-}
modalConfig : Bool -> Attribute msg
modalConfig isFullScreenModal =
    property "modalPage" (E.bool isFullScreenModal)


{-| Sets encoded items to [listViewWithSingleTemplate](Native#listViewWithSingleTemplate) or [listViewWithMultipleTemplate](Native#listViewWithMultipleTemplate)
-}
items : ListViewModel a -> Attribute msg
items listViewModel =
    property "items" (Native.getEncodedItems listViewModel)
