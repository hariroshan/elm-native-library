module Main exposing (main)

import Browser
import Html exposing (Html)
import Json.Decode as D
import Json.Encode as E
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



{-
   Native.datePicker
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

       Native.label [ NA.textWrap "true" ]
                           [ Native.formattedString []
                               [ Native.span
                                   [ NA.text "red"
                                   , NA.style "color: red"
                                   ]
                                   []
                               ]
                           ]

        Native.activityIndicator
                [ NA.busy "true"
                , NA.color "#610fc8"
                ]
                []
        Layout.asElement <|
                Layout.flexboxLayout
                    [ NA.flexDirection "column"
                    ]
                    [ Native.listPicker
                        [ E.list E.string
                            [ "2022", "2021", "2020" ]
                            |> NA.items
                        , NA.selectedIndex "1"
                        ]
                        []
                    ]

        Native.progress
                [ NA.value "50"
                , NA.maxValue "100"
                , NA.backgroundColor "red"
                , NA.color "green"
                , NA.scaleY "2"
                ]
                []
        Native.label
                [ NA.text "Elm Counter"
                , NA.textAlignment "center"
                , NA.color "#610fc8"
                , NA.fontSize "40"
                ]
                []

            , Native.listPicker
                [ E.list E.string
                    [ "2022", "2021", "2020" ]
                    |> NA.items
                , NA.selectedIndex "1"
                ]
                []
-}


detailsPage : Model -> Page.Page Msg
detailsPage model =
    Page.page []
        (
            Layout.scrollView [ ]
            [ -- Event.on "navigatedTo" (D.succeed Destory)
              Layout.asElement <|
                Layout.gridLayout [ NA.rows "200 200 200 200 200 200 200 200 200 200" ]
                    [ Native.label [ NA.row "0", NA.text "row content goes here..." ] []
                    , Native.label [ NA.row "1", NA.text "row content goes here..." ] []
                    , Native.label [ NA.row "2", NA.text "row content goes here..." ] []
                    , Native.label [ NA.row "3", NA.text "row content goes here..." ] []
                    , Native.label [ NA.row "4", NA.text "row content goes here..." ] []
                    , Native.label [ NA.row "5", NA.text "row content goes here..." ] []
                    , Native.label [ NA.row "6", NA.text "row content goes here..." ] []
                    , Native.label [ NA.row "7", NA.text "row content goes here..." ] []
                    , Native.label [ NA.row "8", NA.text "row content goes here..." ] []
                    , Native.label [ NA.row "9", NA.text "row content goes here..." ] []
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
