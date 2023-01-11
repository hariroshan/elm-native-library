module Native.Page exposing (Page, page, unwrap, pageWithActionBar)

import Html exposing (Attribute, Html)
import Native.Layout as Layout exposing (Layout)


type Page msg
    = Page (Html msg)


page : List (Attribute msg) -> Layout msg -> Page msg
page attrs layout =
    Page
        (Html.node "ns-page"
            attrs
            [ Layout.asElement layout ]
        )


pageWithActionBar : List (Attribute msg) -> List (Html msg) -> Page msg
pageWithActionBar attrs layout =
    Page
        (Html.node "ns-page"
            attrs
            layout
        )


unwrap : Page msg -> Html msg
unwrap (Page e) =
    e
