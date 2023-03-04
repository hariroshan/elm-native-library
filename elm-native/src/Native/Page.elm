module Native.Page exposing
    ( modal
    , page
    , pageWithActionBar
    )

{-| Page is a UI component that represents an application screen. NativeScript apps typically consist of one or more <Page> that wrap content such as an <ActionBar> and other UI widgets.
[refer](https://docs.nativescript.org/ui-and-styling.html#page)


# Functions

@docs modal
@docs page
@docs pageWithActionBar

-}

import Html exposing (Attribute, Html)
import Json.Decode as D
import Native.Attributes as N
import Native.Event as Event


{-| Page takes onBackNavigation which should be used to SyncFrame

Example
SyncFrame bool ->
( { model | rootFrame = Frame.handleBack bool model.rootFrame }, Cmd.none )

Page takes only one child

-}
page : (Bool -> msg) -> List (Attribute msg) -> Html msg -> Html msg
page onBackNavigation attrs layout =
    Html.node "ns-page"
        (makeOnBackNavigation onBackNavigation :: attrs)
        [ layout ]


{-| Similar to page but actionBar support
-}
pageWithActionBar : (Bool -> msg) -> List (Attribute msg) -> Html msg -> Html msg -> Html msg
pageWithActionBar onBackNavigation attrs actionBar layout =
    Html.node "ns-page"
        (makeOnBackNavigation onBackNavigation :: attrs)
        [ actionBar, layout ]


makeOnBackNavigation : (Bool -> value) -> Attribute value
makeOnBackNavigation msg =
    Event.on "navigatedTo" (D.field "isBackNavigation" D.bool |> D.map msg)


{-| Used to make modal page
-}
modal : (Bool -> msg) -> Bool -> Html msg -> Html msg
modal syncFrame isFullScreen child =
    page syncFrame
        [ N.modalConfig isFullScreen
        , Event.onUnloaded (syncFrame True)
        ]
        child
