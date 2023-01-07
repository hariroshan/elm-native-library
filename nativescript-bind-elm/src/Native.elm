module Native exposing (button, label)

import Html exposing (Attribute, Html)


type Native
    = Native


buildElement : String -> List (Attribute msg) -> List (Html msg) -> Html msg
buildElement nodeName attrs children =
    Html.node nodeName attrs children


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    buildElement "ns-label"


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    buildElement "ns-button"
