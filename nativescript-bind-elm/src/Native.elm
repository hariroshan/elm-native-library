module Native exposing (label)

import Html exposing (Attribute, Html)


type Native
    = Native

label : List (Attribute msg) -> List (Html msg) -> Html msg
label attrs children =
    Html.node "ns-label" attrs children

