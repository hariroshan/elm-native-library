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
import Process
import Task


main : Program () Model Msg
main =
    Browser.element
        { init = always init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type NavPage
    = Details


type alias Model =
    { count : Int
    , options : List String
    , current : NavPage
    , next : Maybe NavPage
    , history : List NavPage
    }


init : ( Model, Cmd Msg )
init =
    ( { count = 0
      , options = [ "2022", "2021", "2020" ]
      , current = Details
      , history = [ Details ]
      , next = Just Details
      }
    , Cmd.none
    )


type Msg
    = Inc
    | Dec
    | Replace



-- | GoToDetails
-- | Destory


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Replace ->
            ( { model
                | options =
                    List.range 0 model.count
                        |> List.map String.fromInt
              }
            , Cmd.none
            )

        Dec ->
            ( { model | count = model.count - 1 }
            , Process.sleep 2000
                |> Task.perform (always Replace)
            )

        Inc ->
            ( { model | count = model.count + 1 }, Cmd.none )



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
    Page.pageWithActionBar []
        -- Event.on "navigatedTo" (D.succeed Destory)
        -- [ Native.actionBar []
        [ Native.listView
            [ E.list E.int [ 2022, 2021, 2020, 2019, 2018, 2017 ] |> NA.items
            , NA.itemTemplateSelector "{{ $value % 2 == 0 ? 'even' : 'odd' }}"
            ]
            [ Layout.asElement <|
                Layout.stackLayout
                    [ NA.key "even" ]
                    [ Native.label [ NA.text "{{ $value.toString() }}", NA.color "green" ] []
                    ]
            , Layout.asElement <|
                Layout.stackLayout
                    [ NA.key "odd" ]
                    [ Native.label [ NA.text "{{ $value.toString() }}", NA.color "red" ] [] ]
            ]

        --     Native.actionBar [ NA.flat "true", NA.title "Home" ]
        --     []
        -- , Layout.asElement <|
        --
        ]


view : Model -> Html Msg
view model =
    Frame.frame model
        [ ( Details, detailsPage )
        ]
        []
        |> Frame.root


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
