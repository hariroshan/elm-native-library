module Native.Layout exposing
    ( absoluteLayout
    , dockLayout
    , flexboxLayout
    , gridLayout
    , rootLayout
    , scrollView
    , stackLayout
    , tabView
    , wrapLayout
    )

import Html exposing (Attribute, Html)


buildLayout : String -> List (Attribute msg) -> List (Html msg) -> Html msg
buildLayout nodeName attrs children =
    Html.node nodeName attrs children


absoluteLayout : List (Attribute msg) -> List (Html msg) -> Html msg
absoluteLayout =
    buildLayout "ns-absolute-layout"


dockLayout : List (Attribute msg) -> List (Html msg) -> Html msg
dockLayout =
    buildLayout "ns-dock-layout"


gridLayout : List (Attribute msg) -> List (Html msg) -> Html msg
gridLayout =
    buildLayout "ns-grid-layout"


stackLayout : List (Attribute msg) -> List (Html msg) -> Html msg
stackLayout =
    buildLayout "ns-stack-layout"


rootLayout : List (Attribute msg) -> List (Html msg) -> Html msg
rootLayout =
    buildLayout "ns-root-layout"


wrapLayout : List (Attribute msg) -> List (Html msg) -> Html msg
wrapLayout =
    buildLayout "ns-wrap-layout"


flexboxLayout : List (Attribute msg) -> List (Html msg) -> Html msg
flexboxLayout =
    buildLayout "ns-flexbox-layout"


scrollView : List (Attribute msg) -> List (Html msg) -> Html msg
scrollView =
    buildLayout "ns-scroll-view"


tabView : List (Attribute msg) -> List (Html msg) -> Html msg
tabView =
    buildLayout "ns-tab-view"
