module Native exposing
    ( ListViewModel, Native
    , actionBar
    , actionItem
    , activityIndicator
    , button
    , datePicker
    , formattedString
    , getEncodedItems
    , getListItems
    , htmlView
    , image
    , label
    , listPicker
    , listViewWithMultipleTemplate
    , listViewWithSingleTemplate
    , makeListViewModel
    , mapListViewModel
    , navigationButton
    , placeholderView
    , progress
    , scrollView
    , searchBar
    , segmentedBar
    , segmentedBarItem
    , slider
    , span
    , switch
    , tabViewItem
    , textField
    , textView
    , timePicker
    , webView
    )

{-| This library should be used with [elm-native](https://github.com/hariroshan/elm-native) JS library

We will use [CustomElements](https://guide.elm-lang.org/interop/custom_elements.html) feature to create mobile UI elements with nativescript objects and control the nativescript object from elm.

Here's a simple representation of how UI elements are created

`Elm` -> `Nativescript` -> `Mobile`

When we listen for / receive an event,

`Mobile` -> `Nativescript` -> `Elm`

Consider this flow while building an application. This will help you to overcome performance issues if you encounter them.


# Types

@docs ListViewModel, Native


# Functions

@docs actionBar
@docs actionItem
@docs activityIndicator
@docs button
@docs datePicker
@docs formattedString
@docs getEncodedItems
@docs getListItems
@docs htmlView
@docs image
@docs label
@docs listPicker
@docs listViewWithMultipleTemplate
@docs listViewWithSingleTemplate
@docs makeListViewModel
@docs mapListViewModel
@docs navigationButton
@docs placeholderView
@docs progress
@docs scrollView
@docs searchBar
@docs segmentedBar
@docs segmentedBarItem
@docs slider
@docs span
@docs switch
@docs tabViewItem
@docs textField
@docs textView
@docs timePicker
@docs webView

-}

import Html exposing (Attribute, Html)
import Html.Attributes exposing (attribute)
import Json.Encode as E


{-| Just an alias for Html. This allows the usage of Html.Lazy packages when needed.
-}
type alias Native msg =
    Html msg


buildElement : String -> List (Attribute msg) -> List (Html msg) -> Html msg
buildElement nodeName attrs children =
    Html.node nodeName attrs children


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#label)

label is a UI component that displays read-only text.
This <Label> is not the same as the HTML <label>.

    label
        [ text "Elm"
        , textAlignment "center"
        , color "#610fc8"
        , fontSize "40"
        ]
        []

-}
label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    buildElement "ns-label"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#button)

Button is a UI component that displays a button which reacts to a user gesture.
For more information about the available gestures, see [Gestures in the documentation](https://docs.nativescript.org/interaction.html#gestures).

    button [ text "Tap me!", onTap ButtonTappedMsg ] []

-}
button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    buildElement "ns-button"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#activity-indicator)

ActivityIndicator is a UI component that shows a progress indicator signaling to the user of an operation running in the background.

    activityIndicator
        [ busy isBusy
        , onBusyChange SomeMessage
        , onLoaded IndicatorLoaded
        , color "#610fc8"
        ]
        []

-}
activityIndicator : List (Attribute msg) -> List (Html msg) -> Html msg
activityIndicator =
    buildElement "ns-activity-indicator"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#example-styling-the-label)

If you need to style parts of the text, you can use a combination of a FormattedString and Span elements.

    formattedString []
        [ span [ text "Hello", fontStyle "bold" ] []
        , span [ text "World", fontStyle "italic" ]
        ]

-}
formattedString : List (Attribute msg) -> List (Html msg) -> Html msg
formattedString =
    buildElement "ns-formatted-string"


{-| Similar to Html span, we can use it in combination with [formattedString](Native#formattedString)

    span [ text "Hello", fontStyle "bold", style "color: red" ] []

-}
span : List (Attribute msg) -> List (Html msg) -> Html msg
span =
    buildElement "ns-span"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#date-picker)

DatePicker is a UI component that lets users select a date from a pre-configured range.

    datePicker
        [ year "1980"
        , month "4"
        , day "20"
        , minDate "1980-02-01"
        ]
        []

-}
datePicker : List (Attribute msg) -> List (Html msg) -> Html msg
datePicker =
    buildElement "ns-datepicker"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#htmlview)

HtmlView is a UI component that lets you show static HTML content. See also [WebView](Native#webView)

    htmlView [ html "<div><h1>HtmlView</h1></div>" ] []

    htmlView
        [ html """
          <!DOCTYPE html>
          <html>
              <head>
              </head>
              <body>
                  <span style="color: green">Hello World</span>
              </body>
          </html>
          """
        ]
        []

-}
htmlView : List (Attribute msg) -> List (Html msg) -> Html msg
htmlView =
    buildElement "ns-html-view"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#image)

Image is a UI component that shows an image from an ImageSource or from a URL.
When working with images following the [best practices](https://docs.nativescript.org/performance.html#image-optimizations) is a must.

    image [ src "res://icon" stretch "aspectFill" ] []

    image [ src imageUrl, stretch "aspectFill", height "200" ] []

-}
image : List (Attribute msg) -> List (Html msg) -> Html msg
image =
    buildElement "ns-image"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#list-picker)

ListPicker is a UI component that lets the user select a value from a pre-configured list.
We have to encode as `List String` values and pass the encoded value into [items](Native-Attributes#items)

    listPicker
        [ E.list E.string
            [ "2022", "2021", "2020" ]
            |> items
        , selectedIndex "1"
        ]
        []

-}
listPicker : List (Attribute msg) -> List (Html msg) -> Html msg
listPicker =
    buildElement "ns-list-picker"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#progress)

Progress is a UI component that shows a bar to indicate the progress of a task.

    progress
        [ value "50"
        , maxValue "100"
        , backgroundColor "red"
        , color "green"
        , scaleY "2"
        ]
        []

-}
progress : List (Attribute msg) -> List (Html msg) -> Html msg
progress =
    buildElement "ns-progress"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#scrollview)

ScrollView is a UI component that shows a scrollable content area. Content can be scrolled vertically or horizontally.

It's important to note that `ScrollView` extends `ContentView`, so it can only have a single child element.

    scrollView [ orientation "horizontal" ] <|
        stackLayout []
            [ label [ text "this" ] []
            , label [ text "text" ] []
            , label [ text "scrolls" ] []
            , label [ text "horizontally" ] []
            , label [ text "if necessary" ] []
            ]

-}
scrollView : List (Attribute msg) -> Html msg -> Html msg
scrollView attrs child =
    buildElement "ns-scroll-view" attrs [ child ]


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#searchbar)

SearchBar is a UI component that provides a user interface for entering search queries and submitting requests to the search provider.

    searchBar
        [ hint "Search hint"
        , text "searchPhrase"
        , on "submit" (Decode.succeed Submitted)
        , on "clear" (Decode.succeed Cleared)
        ]
        []

-}
searchBar : List (Attribute msg) -> List (Html msg) -> Html msg
searchBar =
    buildElement "ns-search-bar"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#segmentedbar)

`SegmentedBar` is a UI bar component that displays a set of buttons for discrete selection. Can show text or images.

    segmentedBar []
        [ segmentedBarItem [ title "First" ] []
        , segmentedBarItem [ title "Second" ] []
        , segmentedBarItem [ title "Third" ] []
        ]

As opposed to `TabView`:

  - The position of SegmentedBar is not fixed.
  - You can place and style it as needed on the page or inside additional app elements such as hamburger menus.
  - You need to handle the content shown after selection separately.

-}
segmentedBar : List (Attribute msg) -> List (Html msg) -> Html msg
segmentedBar =
    buildElement "ns-segmented-bar"


{-| Child for segmentedBar.
-}
segmentedBarItem : List (Attribute msg) -> List (Html msg) -> Html msg
segmentedBarItem =
    buildElement "ns-segmented-bar-item"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#slider)

Slider is a UI component that provides a slider control for picking values within a specified numeric range.
It returns `Float` value. Don't try to truncate `Float` and set `Int` value for slider value. This will result in weird/janky UI experience.
If you want `Int`, then have 2 fields for slider like `sliderFloatValue` and `sliderIntValue` in `Model`

    slider
        [ row "1"
        , colSpan "2"
        , minValue "0"
        , maxValue "5"
        , value (someValue |> String.fromFloat)
        , onValueChange Changed
        ]
        []

-}
slider : List (Attribute msg) -> List (Html msg) -> Html msg
slider =
    buildElement "ns-slider"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#switch)

Switch is a UI component that lets users toggle between two states.

The default state is false or OFF.

    switch [ checked True ] []

-}
switch : List (Attribute msg) -> List (Html msg) -> Html msg
switch =
    buildElement "ns-switch"


{-| Should be the child of [tabView](Native-Layout#tabView)

    tabView []
        [ tabViewItem [ title "Profile" ]
            [ label [ text "Hello" ] []
            ]
        ]

-}
tabViewItem : List (Attribute msg) -> List (Html msg) -> Html msg
tabViewItem =
    buildElement "ns-tab-view-item"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#textfield)

TextField is an input component that creates an editable single-line box.

TextField extends `TextBase` and `EditableTextBase` which provide additional properties and events.

    textField
        [ hint "Enter Text"
        , color "orangered"
        , backgroundColor "lightyellow"
        ]
        []

-}
textField : List (Attribute msg) -> List (Html msg) -> Html msg
textField =
    buildElement "ns-textfield"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#textview)

TextView is a UI component that shows an editable or a read-only multi-line text container. You can use it to let users type large text in your app or to show longer, multi-line text on the screen.

TextView extends `TextBase` and `EditableTextBase` which provide additional properties and events.

    textView
        [ hint "Enter Date"
        , text "Hello World"
        , secure "false"
        , keyboardType "datetime"
        , returnKeyType "done"
        , autocorrect "false"
        , maxLength "10"
        ]
        []

-}
textView : List (Attribute msg) -> List (Html msg) -> Html msg
textView =
    buildElement "ns-text-view"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#timepicker)

TimePicker is a UI component that lets users select time.

    timePicker
        [ hour "10"
        , minute "25"
        , row "2"
        , col "0"
        , colSpan "2"
        , class "m-15"
        , verticalAlignment "center"
        , on "timeChange" (Decode.succeed TimeChanged)
        ]
        []

-}
timePicker : List (Attribute msg) -> List (Html msg) -> Html msg
timePicker =
    buildElement "ns-time-picker"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#webview)

WebView is a UI component that lets you show web content in your app. You can pull and show content from a URL or a local HTML file, or you can render static HTML content.

    webView [ src "<div><h1>Some static HTML</h1></div>" ] []

    webView [ src "http://nativescript.org/" ] []

    webView [ src "~/html/index.html" ] []

-}
webView : List (Attribute msg) -> List (Html msg) -> Html msg
webView =
    buildElement "ns-web-view"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#actionbar)

The ActionBar is NativeScript’s abstraction over the Android ActionBar and iOS NavigationBar. It represents a toolbar at the top of the activity window, and can have a title, application-level navigation, as well as other custom interactive items.

    actionBar [ title "Elm Native Flix" ] []

    actionBar []
        [ label [ text "Browse", fontSize "18" ] []
        ]

    actionBar [ title "Action Title" ]
        [ navigationButton [ text "Back" ] []
        ]

    -- Advanced usage
    actionBar
        []
        [ navigationButton [ visibility "collapsed" ] []
        , label [ text "Edit Car Details", fontSize "18" ] []
        , actionItem
            [ text "Cancel"
            , iosPosition "left"
            , onTap GoBack
            ]
            []
        , actionItem
            [ text "Done"
            , iosPosition "right"
            , onTap DoneEditing
            ]
            []
        ]

-}
actionBar : List (Attribute msg) -> List (Html msg) -> Html msg
actionBar =
    buildElement "ns-action-bar"


{-| Action Item should be a child of actionBar. Refer [actionBar](Native#actionBar) for example
-}
actionItem : List (Attribute msg) -> List (Html msg) -> Html msg
actionItem =
    buildElement "ns-action-item"


{-| Left navigation button in action bar.
-}
navigationButton : List (Attribute msg) -> List (Html msg) -> Html msg
navigationButton =
    buildElement "ns-navigation-button"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#placeholder)

Placeholder allows you to add any native widget to your application. To do that, you need to put a Placeholder somewhere in the UI hierarchy and then create and configure the native widget that you want to appear there. Finally, pass your native widget to the event arguments of the creatingView event.
Use ports to have access to the rendering element and its native object.

    placeholderView
        [ id "placeholder"
        , on "creatingView" (Decode.succeed CreatingPlaceholder)
        ]
        []

-}
placeholderView : List (Attribute msg) -> List (Html msg) -> Html msg
placeholderView =
    buildElement "ns-placeholder"


{-| [Refer](https://docs.nativescript.org/ui-and-styling.html#listview)

ListView is a UI component that shows items in a vertically scrolling list.
Using a ListView requires some special attention due to the complexity of the native implementations, with custom item templates, bindings and so on.

    listViewWithSingleTemplate
        [ height "100%"
        , separatorColor "transparent"
        , items listViewModel
        , Event.onItemTap ToDetails
        ]
    <|
        Layout.gridLayout
            [ height "280"
            , borderRadius "10"
            , class "bg-secondary"
            , rows "*, auto, auto"
            , columns "*"
            , margin "5, 10"
            , padding "0"
            ]
            [ image
                [ row "0"
                , margin "0"
                , stretch "aspectFill"
                , bindAttributeWithExpression "src" " $value.image "
                ]
                []
            , label
                [ row "1"
                , margin "10, 10, 0, 10"
                , fontWeight "700"
                , class "text-primary"
                , fontSize "18"
                , bindAttributeWithExpression "title" " $value.title "
                ]
                []
            , label
                [ row "2"
                , margin "0, 10, 10, 10"
                , class "text-secondary"
                , fontSize "14"
                , textWrap "true"
                , bindAttributeWithExpression "text" " $value.description "
                ]
                []
            ]

-}
listViewWithSingleTemplate : List (Attribute msg) -> Html msg -> Html msg
listViewWithSingleTemplate attrs child =
    buildElement "ns-list-view" attrs [ child ]


{-| To build a ListView with multiple templates and choose one based on the item,
We need to build `templateSelectorExpression`. templateSelectorExpression has access to $value and $index variables.
In addition to that, we should set a `key` attribute for all the children which will act as template id when picking the right template.

    import Attributes as N
    ...

    listViewWithMultipleTemplate
        -- Use single quotes (') to create a JS string.
        (dangerousEvalExpression " ($value % 2 == 0) || ($index % 3 == 0) ? 'even' : 'odd' " )
        [ items model.items -- here items is ListViewModel Int
        ]
        -- Since $value is Int, we can use .toString() method on number to convert a number to string
        [ Layout.stackLayout [ key "odd", color "red" ]
            [ label [ text (bindingExpression " $value.toString() " ) ] []
            ]
        , Layout.stackLayout [ key "even", color "green" ]
            [ label [ text (bindingExpression " $value.toString() " ) ] []
            ]
        ]

-}
listViewWithMultipleTemplate : String -> List (Attribute msg) -> List (Html msg) -> Html msg
listViewWithMultipleTemplate templateSelectorExpression attrs children =
    buildElement "ns-list-view"
        (itemTemplateSelector templateSelectorExpression
            :: attrs
        )
        children


{-| This attribute have access to $value and $index variables.
Use this when you have to pick different template based on item
-}
itemTemplateSelector : String -> Attribute msg
itemTemplateSelector =
    attribute "item-template-selector"


{-| Used to abstract complexity of syncing items and encoded value
-}
type ListViewModel a
    = ListModel { items : List a, encoded : E.Value }


{-| Builds list view model when given encoder function for the value
-}
makeListViewModel : (a -> E.Value) -> List a -> ListViewModel a
makeListViewModel encoder ls =
    ListModel { items = ls, encoded = E.list encoder ls }


{-| Maps the value. Similar to `List.map`
-}
mapListViewModel : (item2 -> E.Value) -> (item1 -> item2) -> ListViewModel item1 -> ListViewModel item2
mapListViewModel encoder mapper (ListModel record) =
    let
        values =
            record.items
                |> List.map mapper
    in
    makeListViewModel encoder values


{-| Gets items from the model
-}
getListItems : ListViewModel a -> List a
getListItems (ListModel record) =
    record.items


{-| Gets encoded items from the model
-}
getEncodedItems : ListViewModel a -> E.Value
getEncodedItems (ListModel record) =
    record.encoded
