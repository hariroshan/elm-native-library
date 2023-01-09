module Native exposing (activityIndicator, button, formattedString, label, span)

import Html exposing (Attribute, Html)


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
