module Native.Page exposing
    ( modal
    , page
    , pageWithActionBar
    )

import Html exposing (Attribute, Html)
import Json.Decode as D
import Native.Attributes as N
import Native.Event as Event


page : (Bool -> msg) -> List (Attribute msg) -> Html msg -> Html msg
page onBackNavigation attrs layout =
    Html.node "ns-page"
        (makeOnBackNavigation onBackNavigation :: attrs)
        [ layout ]


pageWithActionBar : (Bool -> msg) -> List (Attribute msg) -> Html msg -> Html msg -> Html msg
pageWithActionBar onBackNavigation attrs actionBar layout =
    Html.node "ns-page"
        (makeOnBackNavigation onBackNavigation :: attrs)
        [ actionBar, layout ]


makeOnBackNavigation : (Bool -> value) -> Attribute value
makeOnBackNavigation msg =
    Event.on "navigatedTo" (D.field "isBackNavigation" D.bool |> D.map msg)


modal : (Bool -> msg) -> Bool -> Html msg -> Html msg
modal syncFrame isFullScreen child =
    page syncFrame
        [ N.modalConfig isFullScreen
        , Event.onUnloaded (syncFrame True)
        ]
        child
