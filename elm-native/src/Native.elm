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
    , listView
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
    , webView, makeListViewModel
    )

import Html exposing (Attribute, Html)
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


listView : List (Attribute msg) -> List (Html msg) -> Html msg
listView =
    buildElement "ns-list-view"


placeholderView : List (Attribute msg) -> List (Html msg) -> Html msg
placeholderView =
    buildElement "ns-placeholder"


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
