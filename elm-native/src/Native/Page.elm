module Native.Page exposing
    ( page
    , pageWithActionBar
    )

import Html exposing (Attribute, Html)


page : List (Attribute msg) -> Html msg -> Html msg
page attrs layout =
    Html.node "ns-page"
        attrs
        [ layout ]


pageWithActionBar : List (Attribute msg) -> Html msg -> Html msg -> Html msg
pageWithActionBar attrs actionBar layout =
    Html.node "ns-page"
        attrs
        [ actionBar, layout ]
