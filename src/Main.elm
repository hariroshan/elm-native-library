module Main exposing (main)

import Browser
import Html exposing (Html)
import Json.Decode as D
import Native
import Native.Attributes
import Native.Event as Event
import Native.Frame as Frame
import Native.Layout as Layout exposing (rootLayout)
import Native.Page as Page


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type NavPage
    = Details


type alias Model =
    { count : Int
    , current : NavPage
    , next : Maybe NavPage
    , history : List NavPage
    }


init : Model
init =
    { count = 0
    , current = Details
    , history = [ Details ]
    , next = Just Details
    }


type Msg
    = Inc
    | Dec



-- | GoToDetails
-- | Destory


update : Msg -> Model -> Model
update msg model =
    case msg of
        Dec ->
            { model | count = model.count - 1 }

        Inc ->
            { model | count = model.count + 1 }



-- GoToDetails ->
--     { model | history = Details :: model.history, next = Just Details }
-- Destory ->
--     { model
--         | next = Nothing
--         , history =
--             case model.next of
--                 Nothing ->
--                     model.history |> List.drop 1
--                 Just _ ->
--                     model.history
--     }


helloWorld : Int -> Html msg
helloWorld count =
    Native.label [ Native.Attributes.text ("count " ++ String.fromInt count) ] []



--     helloWorld model.count
-- , Native.button [ Native.Attributes.text "Tap", Event.on "tap" (D.succeed Inc) ] []


detailsPage : Model -> Page.Page Msg
detailsPage model =
    Page.page []
        -- Event.on "navigatedTo" (D.succeed Destory)
        (Layout.flexboxLayout
            [ Native.Attributes.flexDirection "column"
            , Native.Attributes.backgroundColor "#3c495e"
            ]
            [ Native.label
                [ Native.Attributes.text "first"
                , Native.Attributes.backgroundColor "#43b883"
                , Native.Attributes.width "70"
                ]
                []
            , Native.label
                [ Native.Attributes.text "second"
                , Native.Attributes.backgroundColor "#1c6b48"
                , Native.Attributes.width "70"
                ]
                []
            , Native.label
                [ Native.Attributes.text "third"
                , Native.Attributes.backgroundColor "#289062"
                , Native.Attributes.width "70"
                ]
                []
            ]
        )


view : Model -> Html Msg
view model =
    detailsPage model
        |> Page.unwrap
    -- Frame.frame model
    --     [ ( Details, detailsPage )
    --     ]
    --     []
    --     |> Frame.root
