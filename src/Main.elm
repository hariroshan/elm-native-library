module Main exposing (main)

import Browser
import Html exposing (Html)
import Json.Decode as D
import Native
import Native.Attributes as NA
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
    Native.label
        [ NA.text (String.fromInt count)
        , NA.color "red"
        , NA.fontSize "32"
        ]
        []



--     helloWorld model.count
-- , Native.button [ NA.text "Tap", Event.on "tap" (D.succeed Inc) ] []


counter model =
    Layout.asElement <|
        Layout.flexboxLayout
            [ NA.justifyContent "space-between"
            , NA.height "70%"
            ]
            [ Native.button
                [ NA.text "Increment"
                , Event.on "tap" (D.succeed Inc)
                , NA.fontSize "24"
                ]
                []
            , helloWorld model.count
            , Native.button
                [ Event.on "tap" (D.succeed Dec)
                , NA.fontSize "24"
                ]
                [ Native.formattedString []
                    [ Native.span
                        [ NA.text "Decrement"
                        , NA.style "color: red"
                        , NA.fontStyle "italic"
                        ]
                        []
                    ]
                ]
            ]


detailsPage : Model -> Page.Page Msg
detailsPage model =
    Page.page []
        (Layout.stackLayout []
            [ -- Event.on "navigatedTo" (D.succeed Destory)
              Native.label
                [ NA.text "Elm Counter"
                , NA.textAlignment "center"
                , NA.color "#610fc8"
                , NA.fontSize "40"
                ]
                []
            , Native.activityIndicator
                [ NA.busy "true"
                , NA.color "#610fc8"
                ]
                []
            , Layout.asElement <|
                Layout.flexboxLayout
                    [ NA.flexDirection "column"
                    ]
                    [ Native.datePicker
                        [ NA.year "1980"
                        , NA.month "4"
                        , NA.day "20"
                        , NA.minDate "1980-02-01"
                        ]
                        []
                    , Native.htmlView
                        [ NA.html """
                        <!DOCTYPE html>
                        <html>
                            <head>
                            </head>
                            <body>
                                <span style="color: green">Hello World</span>
                            </body>
                        </html>
                        """
                        ]
                        []
                    ]
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
