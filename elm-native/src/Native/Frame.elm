module Native.Frame exposing
    ( Model
    , TransitionCurve(..)
    , TransitionName(..)
    , defaultNavigationOptions
    , frame
    , goBack
    , goTo
    , handleBack
    , init
    , setAnimated
    , setBackstackVisible
    , setClearHistory
    , setTransition
    , setTransitionAndroid
    , setTransitioniOS
    )

import Html exposing (Attribute, Html)
import Html.Attributes exposing (property)
import Json.Encode as E


type alias Model page =
    { current : page
    , history : List page
    , encodedNavigationOptions : E.Value
    , popStack : Bool
    }


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


type TransitionCurve
    = Ease
    | EaseIn
    | EaseInOut
    | EaseOut
    | Linear
    | Spring


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


defaultNavigationOptions : NavigationOptions
defaultNavigationOptions =
    { animated = Nothing
    , transition = Nothing
    , transitioniOS = Nothing
    , transitionAndroid = Nothing
    , backstackVisible = Nothing
    , clearHistory = Nothing
    }


setAnimated : b -> { a | animated : Maybe b } -> { a | animated : Maybe b }
setAnimated val mod =
    { mod | animated = Just val }


setTransition : b -> { a | transition : Maybe b } -> { a | transition : Maybe b }
setTransition val mod =
    { mod | transition = Just val }


setTransitioniOS : b -> { a | transitioniOS : Maybe b } -> { a | transitioniOS : Maybe b }
setTransitioniOS val mod =
    { mod | transitioniOS = Just val }


setTransitionAndroid : b -> { a | transitionAndroid : Maybe b } -> { a | transitionAndroid : Maybe b }
setTransitionAndroid val mod =
    { mod | transitionAndroid = Just val }


setBackstackVisible : b -> { a | backstackVisible : Maybe b } -> { a | backstackVisible : Maybe b }
setBackstackVisible val mod =
    { mod | backstackVisible = Just val }


setClearHistory : b -> { a | clearHistory : Maybe b } -> { a | clearHistory : Maybe b }
setClearHistory val mod =
    { mod | clearHistory = Just val }


cons : List a -> a -> List a
cons acc x =
    x :: acc


frame : Model page -> model -> List ( page, model -> Html msg ) -> List (Attribute msg) -> Html msg
frame model appModel pages attrs =
    let
        children =
            pages
                |> getPage model.current appModel
                |> Maybe.map List.singleton
                |> Maybe.withDefault []

        history =
            model.history
                |> List.foldl
                    (\old acc ->
                        pages
                            |> getPage old appModel
                            |> Maybe.map (cons acc)
                            |> Maybe.withDefault acc
                    )
                    children
    in
    Html.node "ns-frame"
        (property "navigationOptions" model.encodedNavigationOptions
            :: property "popStack" (E.bool model.popStack)
            :: attrs
        )
        history


getPage : a -> b -> List ( a, b -> Html msg ) -> Maybe (Html msg)
getPage target model pages =
    pages
        |> findInList target Tuple.first Nothing
        |> Maybe.map
            (\( _, fx ) ->
                model
                    |> fx
            )


findInList : b -> (a -> b) -> Maybe a -> List a -> Maybe a
findInList target toItem acc ls =
    case ls of
        [] ->
            acc

        h :: r ->
            if target == toItem h then
                Just h

            else
                findInList target toItem acc r


init : page -> Model page
init currentPage =
    { current = currentPage
    , history = []
    , encodedNavigationOptions = E.null
    , popStack = False
    }


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


goBack : Model page -> Model page
goBack model =
    { model | popStack = True }


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
