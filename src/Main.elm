module Main exposing (main)

import Browser
import Html exposing (Html)
import Json.Decode as D
import Native
import Native.Attributes
import Native.Event as Event
import Native.Frame as Frame
import Native.Layout exposing (rootLayout)
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
    , next : Maybe NavPage
    , history : List NavPage
    }


init : Model
init =
    let
        _ =
            Debug.log "HEllo from ELM" "World"
    in
    { count = 0, history = [ Details ], next = Nothing  }


type Msg
    = Inc
    | Dec
    | GoToDetails
    | Destory


update : Msg -> Model -> Model
update msg model =
    case msg of
        Dec ->
            { model | count = model.count - 1 }

        Inc ->
            { model | count = model.count + 1 }

        GoToDetails ->
            { model | history = Details :: model.history, next = Just Details }

        Destory ->
            { model
                | next = Nothing
                , history =
                    case model.next of
                        Nothing ->
                            model.history |> List.drop 1

                        Just _ ->
                            model.history
            }


detailsPage : Model -> Page.Page Msg
detailsPage _ =
    Page.page [
        -- Event.on "navigatedTo" (D.succeed Destory)
        ]
        (rootLayout []
            [ Native.label [ Native.Attributes.text "Hello from elm" ] []
            ]
        )


view : Model -> Html Msg
view model =
    Frame.frame
        model
        [ ( Details, detailsPage )
        ]
        []
        |> Frame.root
