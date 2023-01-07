module Native.Layout exposing
    ( Layout
    , absoluteLayout
    , asElement
    , dockLayout
    , flexboxLayout
    , gridLayout
    , rootLayout
    , stackLayout
    , wrapLayout
    )

import Html exposing (Attribute, Html)


type Layout msg
    = Layout (Html msg)


buildLayout : String -> List (Attribute msg) -> List (Html msg) -> Layout msg
buildLayout nodeName attrs children =
    Layout (Html.node nodeName attrs children)


absoluteLayout : List (Attribute msg) -> List (Html msg) -> Layout msg
absoluteLayout =
    buildLayout "ns-absolute-layout"


dockLayout : List (Attribute msg) -> List (Html msg) -> Layout msg
dockLayout =
    buildLayout "ns-dock-layout"


gridLayout : List (Attribute msg) -> List (Html msg) -> Layout msg
gridLayout =
    buildLayout "ns-grid-layout"


stackLayout : List (Attribute msg) -> List (Html msg) -> Layout msg
stackLayout =
    buildLayout "ns-stack-layout"


rootLayout : List (Attribute msg) -> List (Html msg) -> Layout msg
rootLayout =
    buildLayout "ns-root-layout"


wrapLayout : List (Attribute msg) -> List (Html msg) -> Layout msg
wrapLayout =
    buildLayout "ns-wrap-layout"


flexboxLayout : List (Attribute msg) -> List (Html msg) -> Layout msg
flexboxLayout =
    buildLayout "ns-flexbox-layout"


asElement : Layout msg -> Html msg
asElement (Layout e) =
    e
