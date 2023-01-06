module Native.Layout exposing (Layout, asElement, rootLayout)

import Html exposing (Attribute, Html)


type Layout msg
    = Layout (Html msg)


rootLayout : List (Attribute msg) -> List (Html msg) -> Layout msg
rootLayout attrs children =
    Layout (Html.node "ns-root-layout" attrs children)


asElement : Layout msg -> Html msg
asElement (Layout e) =
    e
