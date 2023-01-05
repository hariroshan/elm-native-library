module Main exposing (main)

import Browser
import Html exposing (Html, text)


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }


view : Model -> Html Msg
view model =
    text "Hello"


main : Program () Model Msg
main =
    let
        _ =
            Debug.log "INIT" "ELM"
    in
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
