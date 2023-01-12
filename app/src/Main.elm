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
    = DetailsPage
    | CounterPage


type alias Model =
    { count : Int
    , options : List { title : String }
    , email : String
    , current : NavPage
    , next : Maybe NavPage
    , history : List NavPage
    }


init : ( Model, Cmd Msg )
init =
    ( { count = 0
      , options = [ { title = "Hello" }, { title = "Hola" } ]
      , email = ""
      , current = CounterPage
      , history = []
      , next = Nothing
      }
    , Cmd.none
    )


type Msg
    = Inc
    | Dec
    | Replace
    | ToDetails
    | Back Bool
    | OnTextChange String
    | OnDateChange { day : Int, month : Int, year : Int }



-- | GoToDetails
-- | Destory


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Back False ->
            ( model, Cmd.none )

        Back True ->
            case model.history of
                [] ->
                    ( model, Cmd.none )

                cur :: [] ->
                    ( { model | history = [], current = cur }, Cmd.none )

                _ :: cur :: rest ->
                    ( { model | history = rest, current = cur }, Cmd.none )

        ToDetails ->
            ( { model
                | history = model.current :: model.history
                , current = DetailsPage
              }
            , Cmd.none
            )

        OnDateChange str ->
            ( model, Cmd.none )

        OnTextChange str ->
            ( { model | email = str }, Cmd.none )

        Replace ->
            ( { model
                | options =
                    model.options
                        |> List.indexedMap
                            (\i x ->
                                if i == 0 then
                                    { x | title = "world" }

                                else
                                    x
                            )
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
    Layout.stackLayout []
        [ Layout.flexboxLayout
            [ NA.justifyContent "space-between"
            , NA.height "70%"
            ]
            [ Native.button
                [ NA.text "Increment"
                , Event.onTap Inc
                , NA.fontSize "24"
                ]
                []
            , helloWorld model.count
            , Native.button
                [ Event.onTap Dec
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
        , Native.button
            [ NA.text "Details page"
            , Event.onTap ToDetails
            , NA.fontSize "24"
            ]
            []
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

    Native.listView
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
-}


counterPage : Model -> Html Msg
counterPage model =
    Page.page [ Event.on "navigatedTo" (D.field "isBackNavigation" D.bool |> D.map Back) ] <|
        Layout.stackLayout
            []
            [ counter model
            ]


detailsPage : Model -> Html Msg
detailsPage model =
    let
        _ =
            Debug.log "Model options" model.options
    in
    Page.page [ Event.on "navigatedTo" (D.field "isBackNavigation" D.bool |> D.map Back) ] <|
        Layout.stackLayout
            []
            [ Native.label [ NA.class "h1 text-center", NA.text "Details" ] []
            ]


view : Model -> Html Msg
view model =
    Frame.frame model
        [ ( DetailsPage, detailsPage )
        , ( CounterPage, counterPage )
        ]
        []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
