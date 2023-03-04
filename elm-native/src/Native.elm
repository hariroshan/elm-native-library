module Native exposing
    ( ListViewModel
    , Native
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
{-|
This library should be used with [elm-native](https://github.com/hariroshan/elm-native) JS library


We will use [CustomElements](https://guide.elm-lang.org/interop/custom_elements.html) feature to create mobile UI elements with nativescript objects and control the nativescript object from elm.

Here's a simple representation of how UI elements are created

`Elm` -> `Nativescript` -> `Mobile`

When we listen for / receive an event,

`Mobile` -> `Nativescript` -> `Elm`

Consider this flow while building an application. This will help you to overcome performance issues if you encounter them.

-}
import Html exposing (Attribute, Html)
import Html.Attributes exposing (attribute)
import Json.Encode as E


type alias Native msg =
    Html msg


buildElement : String -> List (Attribute msg) -> List (Html msg) -> Html msg
buildElement nodeName attrs children =
    Html.node nodeName attrs children


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    buildElement "ns-label"


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    buildElement "ns-button"


activityIndicator : List (Attribute msg) -> List (Html msg) -> Html msg
activityIndicator =
    buildElement "ns-activity-indicator"


formattedString : List (Attribute msg) -> List (Html msg) -> Html msg
formattedString =
    buildElement "ns-formatted-string"


span : List (Attribute msg) -> List (Html msg) -> Html msg
span =
    buildElement "ns-span"


datePicker : List (Attribute msg) -> List (Html msg) -> Html msg
datePicker =
    buildElement "ns-datepicker"


htmlView : List (Attribute msg) -> List (Html msg) -> Html msg
htmlView =
    buildElement "ns-html-view"


image : List (Attribute msg) -> List (Html msg) -> Html msg
image =
    buildElement "ns-image"


listPicker : List (Attribute msg) -> List (Html msg) -> Html msg
listPicker =
    buildElement "ns-list-picker"


progress : List (Attribute msg) -> List (Html msg) -> Html msg
progress =
    buildElement "ns-progress"


scrollView : List (Attribute msg) -> Html msg -> Html msg
scrollView attrs child =
    buildElement "ns-scroll-view" attrs [ child ]


searchBar : List (Attribute msg) -> List (Html msg) -> Html msg
searchBar =
    buildElement "ns-search-bar"


segmentedBar : List (Attribute msg) -> List (Html msg) -> Html msg
segmentedBar =
    buildElement "ns-segmented-bar"


segmentedBarItem : List (Attribute msg) -> List (Html msg) -> Html msg
segmentedBarItem =
    buildElement "ns-segmented-bar-item"


slider : List (Attribute msg) -> List (Html msg) -> Html msg
slider =
    buildElement "ns-slider"


switch : List (Attribute msg) -> List (Html msg) -> Html msg
switch =
    buildElement "ns-switch"


tabViewItem : List (Attribute msg) -> List (Html msg) -> Html msg
tabViewItem =
    buildElement "ns-tab-view-item"


textField : List (Attribute msg) -> List (Html msg) -> Html msg
textField =
    buildElement "ns-textfield"


textView : List (Attribute msg) -> List (Html msg) -> Html msg
textView =
    buildElement "ns-text-view"


timePicker : List (Attribute msg) -> List (Html msg) -> Html msg
timePicker =
    buildElement "ns-time-picker"


webView : List (Attribute msg) -> List (Html msg) -> Html msg
webView =
    buildElement "ns-web-view"


actionBar : List (Attribute msg) -> List (Html msg) -> Html msg
actionBar =
    buildElement "ns-action-bar"


actionItem : List (Attribute msg) -> List (Html msg) -> Html msg
actionItem =
    buildElement "ns-action-item"


navigationButton : List (Attribute msg) -> List (Html msg) -> Html msg
navigationButton =
    buildElement "ns-navigation-button"


placeholderView : List (Attribute msg) -> List (Html msg) -> Html msg
placeholderView =
    buildElement "ns-placeholder"


listViewWithSingleTemplate : List (Attribute msg) -> Html msg -> Html msg
listViewWithSingleTemplate attrs child =
    buildElement "ns-list-view" attrs [ child ]


{-| To build a ListView with multiple templates and choose one based on the item,
We need to build `templateSelectorExpression`. templateSelectorExpression has access to $value and $index variables.
In addition to that, we should set a `key` attribute for all the children which will act as template id when picking the right template.

    import Native.Attributes as N
    ...

    listViewWithMultipleTemplate
        -- Use single quotes (') to create a JS string.
        (N.dangerousEvalExpression " ($value % 2 == 0) || ($index % 3 == 0) ? 'even' : 'odd' " )
        [ N.items model.items -- here items is ListViewModel Int
        ]
        -- Since $value is Int, we can use .toString() method on number to convert a number to string
        [ Layout.stackLayout [ N.key "odd", N.color "red" ]
            [ label [ N.text (N.bindingExpression " $value.toString() " ) ] []
            ]
        , Layout.stackLayout [ N.key "even", N.color "green" ]
            [ label [ N.text (N.bindingExpression " $value.toString() " ) ] []
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


type ListViewModel a
    = ListModel { items : List a, encoded : E.Value }


makeListViewModel : (a -> E.Value) -> List a -> ListViewModel a
makeListViewModel encoder ls =
    ListModel { items = ls, encoded = E.list encoder ls }


mapListViewModel : (item2 -> E.Value) -> (item1 -> item2) -> ListViewModel item1 -> ListViewModel item2
mapListViewModel encoder mapper (ListModel record) =
    let
        values =
            record.items
                |> List.map mapper
    in
    makeListViewModel encoder values


getListItems : ListViewModel a -> List a
getListItems (ListModel record) =
    record.items


getEncodedItems : ListViewModel a -> E.Value
getEncodedItems (ListModel record) =
    record.encoded
