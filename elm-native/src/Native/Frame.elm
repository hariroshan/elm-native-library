module Native.Frame exposing
    ( Model
    , TransitionCurve(..)
    , TransitionName(..)
    , defaultNavigationOptions
    , goBack
    , goTo
    , handleBack
    , init
    , mapCurrentPage
    , view
    , setAnimated
    , setBackstackVisible
    , setClearHistory
    , setTransition
    , setTransitionAndroid
    , setTransitioniOS
    )

{-| Frame handles all the navigations between pages, tracks history and so on.

Represents the logical View unit that is responsible for navigation within an application. Nested frames are supported, enabling hierarchical navigation scenarios.


# Types

@docs Model
@docs TransitionCurve
@docs TransitionName


# Functions

@docs defaultNavigationOptions
@docs goBack
@docs goTo
@docs handleBack
@docs init
@docs mapCurrentPage
@docs view


# Setter

@docs setAnimated
@docs setBackstackVisible
@docs setClearHistory
@docs setTransition
@docs setTransitionAndroid
@docs setTransitioniOS

-}

import Html exposing (Attribute, Html)
import Html.Attributes exposing (property)
import Json.Encode as E


{-| Model that holds the frame related data responsible for page rendering and clearing
-}
type alias Model page =
    { current : page
    , history : List page
    , encodedNavigationOptions : E.Value
    , popStack : Bool
    }


{-| Transistion animations supported by frame while navigating to/back page
-}
type TransitionName
    = IosOnlyCurlUp
    | IosOnlyCurlDown
    | AndroidOnlyExplode
    | Fade
    | FlipRight
    | FlipLeft
    | SlideRight
    | SlideLeft
    | SlideTop
    | SlideBottom


{-| Animation for transition animation
-}
type TransitionCurve
    = Ease
    | EaseIn
    | EaseInOut
    | EaseOut
    | Linear
    | Spring
    | CubicBezier ( Float, Float ) ( Float, Float )


{-| Transition options
-}
type alias Transition =
    { name : Maybe TransitionName
    , duration : Maybe Int
    , curve : Maybe TransitionCurve
    }


encodeTransitionCurve : TransitionCurve -> ( String, E.Value )
encodeTransitionCurve curve =
    ( "curve"
    , E.string <|
        case curve of
            Ease ->
                "ease"

            EaseIn ->
                "easeIn"

            EaseInOut ->
                "easeInOut"

            EaseOut ->
                "easeOut"

            Linear ->
                "linear"

            Spring ->
                "spring"

            CubicBezier ( x1, y1 ) ( x2, y2 ) ->
                "cubicBezier("
                    ++ String.fromFloat x1
                    ++ ","
                    ++ String.fromFloat y1
                    ++ ","
                    ++ String.fromFloat x2
                    ++ ","
                    ++ String.fromFloat y2
                    ++ ")"
    )


encodeTransitionName : TransitionName -> ( String, E.Value )
encodeTransitionName name =
    ( "name"
    , E.string <|
        case name of
            IosOnlyCurlUp ->
                "curlUp"

            IosOnlyCurlDown ->
                "curlDown"

            AndroidOnlyExplode ->
                "explode"

            Fade ->
                "fade"

            FlipRight ->
                "flipRight"

            FlipLeft ->
                "flipLeft"

            SlideRight ->
                "slideRight"

            SlideLeft ->
                "slideLeft"

            SlideTop ->
                "slideTop"

            SlideBottom ->
                "slideBottom"
    )


encodeTransition : Transition -> E.Value
encodeTransition transition =
    [ transition.name |> Maybe.map encodeTransitionName
    , transition.curve |> Maybe.map encodeTransitionCurve
    , transition.duration |> Maybe.map (E.int >> Tuple.pair "duration")
    ]
        |> List.filterMap identity
        |> E.object


{-| NavigationOptions is used to configure navigation while navigating to a page
-}
type alias NavigationOptions =
    { animated : Maybe Bool
    , transition : Maybe Transition
    , transitioniOS : Maybe Transition
    , transitionAndroid : Maybe Transition
    , backstackVisible : Maybe Bool
    , clearHistory : Maybe Bool
    }


encodeNavigationOptions : NavigationOptions -> E.Value
encodeNavigationOptions navOptions =
    [ navOptions.animated |> Maybe.map (E.bool >> Tuple.pair "animated")
    , navOptions.transition |> Maybe.map (encodeTransition >> Tuple.pair "transition")
    , navOptions.transitioniOS |> Maybe.map (encodeTransition >> Tuple.pair "transitioniOS")
    , navOptions.transitionAndroid |> Maybe.map (encodeTransition >> Tuple.pair "transitionAndroid")
    , navOptions.backstackVisible |> Maybe.map (E.bool >> Tuple.pair "backstackVisible")
    , navOptions.clearHistory |> Maybe.map (E.bool >> Tuple.pair "clearHistory")
    ]
        |> List.filterMap identity
        |> E.object


{-| Default navigation options
-}
defaultNavigationOptions : NavigationOptions
defaultNavigationOptions =
    { animated = Nothing
    , transition = Nothing
    , transitioniOS = Nothing
    , transitionAndroid = Nothing
    , backstackVisible = Nothing
    , clearHistory = Nothing
    }


{-| Setters for animated
-}
setAnimated : b -> { a | animated : Maybe b } -> { a | animated : Maybe b }
setAnimated val mod =
    { mod | animated = Just val }


{-| Setters for transition
-}
setTransition : b -> { a | transition : Maybe b } -> { a | transition : Maybe b }
setTransition val mod =
    { mod | transition = Just val }


{-| Setters for transitioniOS
-}
setTransitioniOS : b -> { a | transitioniOS : Maybe b } -> { a | transitioniOS : Maybe b }
setTransitioniOS val mod =
    { mod | transitioniOS = Just val }


{-| Setters for transitionAndroid
-}
setTransitionAndroid : b -> { a | transitionAndroid : Maybe b } -> { a | transitionAndroid : Maybe b }
setTransitionAndroid val mod =
    { mod | transitionAndroid = Just val }


{-| Setters for backstackVisible
-}
setBackstackVisible : b -> { a | backstackVisible : Maybe b } -> { a | backstackVisible : Maybe b }
setBackstackVisible val mod =
    { mod | backstackVisible = Just val }


{-| Setters for clearHistory
-}
setClearHistory : b -> { a | clearHistory : Maybe b } -> { a | clearHistory : Maybe b }
setClearHistory val mod =
    { mod | clearHistory = Just val }


{-| Renders the page on to mobile screen
-}
view : List (Attribute msg) -> (page -> Html msg) -> Model page -> Html msg
view attrs getPage frameModel =
    let
        children =
            [ getPage frameModel.current ]

        history =
            frameModel.history
                |> List.foldl
                    (\old acc -> getPage old :: acc)
                    children
    in
    Html.node "ns-frame"
        (property "navigationOptions" frameModel.encodedNavigationOptions
            :: property "popStack" (E.bool frameModel.popStack)
            :: attrs
        )
        history


{-| Map function for mapping current page
-}
mapCurrentPage : (page -> page) -> Model page -> Model page
mapCurrentPage mapFx frameModel =
    { frameModel
        | current =
            frameModel.current
                |> mapFx
    }


{-| init function to initalize frame model
-}
init : page -> Model page
init currentPage =
    { current = currentPage
    , history = []
    , encodedNavigationOptions = E.null
    , popStack = False
    }


{-| Used to sync pages and history when nativescript navigates to different page.
-}
handleBack : Bool -> Model page -> Model page
handleBack isBackNavigation model =
    if not isBackNavigation then
        model

    else
        case model.history of
            [] ->
                model

            cur :: rest ->
                { model
                    | history = rest
                    , current = cur
                    , popStack = False
                }


{-| Allows frame to go back to previous page
-}
goBack : Model page -> Model page
goBack model =
    { model | popStack = True }


{-| Allows frame to move to next page
-}
goTo : page -> Maybe NavigationOptions -> Model page -> Model page
goTo page maybeNavigationOptions model =
    { model
        | history =
            if
                maybeNavigationOptions
                    |> Maybe.andThen .clearHistory
                    |> Maybe.withDefault False
            then
                []

            else
                model.current :: model.history
        , current = page
        , encodedNavigationOptions =
            maybeNavigationOptions
                |> Maybe.map encodeNavigationOptions
                |> Maybe.withDefault E.null
    }
