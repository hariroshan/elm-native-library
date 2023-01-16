module Details exposing (..)

import Browser
import Http
import Json.Decode as D
import Json.Encode as E
import Native exposing (..)
import Native.Attributes as N exposing (bindingExpression, dangerousEvalExpression)
import Native.Event as Event
import Native.Frame as Frame
import Native.Layout as Layout
import Native.Page as Page


type alias Car =
    { class : String
    , doors : Int
    , hasAC : Bool
    , id : String
    , imageStoragePath : String
    , imageUrl : String
    , luggage : Int
    , name : String
    , price : Int
    , seats : String
    , transmission : String
    }


decodeCar : D.Decoder Car
decodeCar =
    D.map8 Car
        (D.field "class" D.string)
        (D.field "doors" D.int)
        (D.field "hasAC" D.bool)
        (D.field "id" D.string)
        (D.field "imageStoragePath" D.string)
        (D.field "imageUrl" D.string)
        (D.field "luggage" D.int)
        (D.field "name" D.string)
        |> D.andThen
            (\fx ->
                D.map3 fx
                    (D.field "price" D.int)
                    (D.field "seats" D.string)
                    (D.field "transmission" D.string)
            )


decodeResponse : D.Decoder (List Car)
decodeResponse =
    D.field "cars" (D.keyValuePairs decodeCar)
        |> D.map (List.map Tuple.second)


encodeCar : Car -> E.Value
encodeCar car =
    [ ( "name", E.string car.name )
    , ( "class", E.string car.class )
    , ( "imageUrl", E.string car.imageUrl )
    , ( "transmission", E.string car.transmission )
    , ( "hasAC", E.bool car.hasAC )
    , ( "price", E.int car.price )
    , ( "id", E.string car.id )
    ]
        |> E.object


encodeCars : List Car -> E.Value
encodeCars =
    E.list encodeCar


response : List Car
response =
    """
    {
        "cars": {
            "car1": {
                "class": "Luxury",
                "doors": 2,
                "hasAC": true,
                "id": "car1",
                "imageStoragePath": "cars/BMW 5 Series.jpg",
                "imageUrl": "https://firebasestorage.googleapis.com/v0/b/car-rental-b26b7.appspot.com/o/cars_public%2FBMW%205%20Series.jpg?alt=media&token=dec5a0bf-e3ca-45d2-8f2e-c7b8a25530b5",
                "luggage": 3,
                "name": "BMW 5 Series",
                "price": 76,
                "seats": "2",
                "transmission": "Automatic"
            },
            "car2": {
                "class": "Luxury",
                "doors": 5,
                "hasAC": false,
                "id": "car2",
                "imageStoragePath": "cars/Ford KA+.jpg",
                "imageUrl": "https://firebasestorage.googleapis.com/v0/b/car-rental-b26b7.appspot.com/o/cars_public%2FFord%20KA%2B.jpg?alt=media&token=cf090183-ef5a-4c05-9f60-b0cbdfda7188",
                "luggage": 3,
                "name": "Ford KA",
                "price": 44,
                "seats": "4 + 1",
                "transmission": "Automatic"
            },
            "car3": {
                "class": "Mini",
                "doors": 3,
                "hasAC": true,
                "id": "car3",
                "imageStoragePath": "cars/Smart.jpg",
                "imageUrl": "https://firebasestorage.googleapis.com/v0/b/car-rental-b26b7.appspot.com/o/cars_public%2FSmart.jpg?alt=media&token=6891aca9-4211-4545-834e-c934ed671961",
                "luggage": 1,
                "name": "Smart",
                "price": 39,
                "seats": "2",
                "transmission": "Manual"
            },
            "car4": {
                "class": "Standard",
                "doors": 5,
                "hasAC": true,
                "id": "car4",
                "imageStoragePath": "cars/Kia Sorento.jpg",
                "imageUrl": "https://firebasestorage.googleapis.com/v0/b/car-rental-b26b7.appspot.com/o/cars_public%2FKia%20Sorento.jpg?alt=media&token=09ba5c41-5039-420f-b4fe-073dedb2ff1c",
                "luggage": 2,
                "name": "Kia Sorento",
                "price": 45,
                "seats": "4 + 1",
                "transmission": "Manual"
            },
            "car5": {
                "class": "Luxury",
                "doors": 3,
                "hasAC": true,
                "id": "car5",
                "imageStoragePath": "cars/Mazda MX-5.jpg",
                "imageUrl": "https://firebasestorage.googleapis.com/v0/b/car-rental-b26b7.appspot.com/o/cars_public%2FMazda%20MX-5.jpg?alt=media&token=d27f2a97-2e09-431e-ad8c-d0e7723955ef",
                "luggage": 2,
                "name": "Mazda MX-5",
                "price": 53,
                "seats": "2",
                "transmission": "Automatic"
            },
            "car6": {
                "class": "Luxury",
                "doors": 3,
                "hasAC": false,
                "id": "car6",
                "imageStoragePath": "cars/Mercedes S-Class Cabriolet.jpg",
                "imageUrl": "https://firebasestorage.googleapis.com/v0/b/car-rental-b26b7.appspot.com/o/cars_public%2FMercedes%20S-Class%20Cabriolet.jpg?alt=media&token=dc17f427-407c-45c5-b827-ed3e108e0034",
                "luggage": 2,
                "name": "Mercedes S-Class Cabriolet",
                "price": 89,
                "seats": "4",
                "transmission": "Manual"
            }
        }
    }
    """
        |> D.decodeString decodeResponse
        |> Result.toMaybe
        |> Maybe.withDefault []


main : Program () Model Msg
main =
    Browser.element
        { init = always init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type NavPage
    = HomePage
    | CarDetailsPage
    | CarDetailsEditPage


type alias Model =
    { rootFrame : Frame.Model NavPage
    , cars : List Car
    , encodedCars : E.Value
    , pickedCar : Maybe Car
    }


type Msg
    = HandleFrameBack Bool
    | GoBack
    | NoOp
    | ToCarDetailsPage Int
    | ToCarDetailsEditPage
    | ItemTap String


init : ( Model, Cmd Msg )
init =
    ( { rootFrame = Frame.init HomePage
      , cars = response
      , encodedCars = encodeCars response
      , pickedCar = Nothing
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ItemTap carId ->
            let
                _ =
                    Debug.log "Car" carId
            in
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

        GoBack ->
            ( { model | rootFrame = Frame.goBack model.rootFrame }, Cmd.none )

        HandleFrameBack bool ->
            ( { model | rootFrame = Frame.handleBack bool model.rootFrame }, Cmd.none )

        ToCarDetailsEditPage ->
            ( { model
                | rootFrame =
                    model.rootFrame
                        |> Frame.goTo CarDetailsEditPage
                            (Frame.defaultNavigationOptions
                                |> Frame.setAnimated True
                                |> Frame.setTransition
                                    { name = Just Frame.SlideTop
                                    , duration = Just 200
                                    , curve = Just Frame.Ease
                                    }
                                |> Just
                            )
              }
            , Cmd.none
            )

        ToCarDetailsPage idx ->
            ( { model
                | rootFrame =
                    model.rootFrame
                        |> Frame.goTo CarDetailsPage
                            (Frame.defaultNavigationOptions
                                |> Frame.setAnimated True
                                |> Frame.setTransition
                                    { name = Just Frame.FlipLeft
                                    , duration = Just 300
                                    , curve = Just Frame.Spring
                                    }
                                |> Just
                            )
                , pickedCar =
                    model.cars
                        |> List.foldl
                            (\cur (( curIdx, acc ) as result) ->
                                if acc /= Nothing then
                                    result

                                else if curIdx == idx then
                                    ( idx, Just cur )

                                else
                                    ( curIdx + 1, acc )
                            )
                            ( 0, Nothing )
                        |> Tuple.second
              }
            , Cmd.none
            )


notFoundPage : Native Msg
notFoundPage =
    Page.page HandleFrameBack
        []
        (Layout.stackLayout []
            [ Native.label [ N.text "Not found" ] []
            ]
        )


carDetailEditView : Model -> Car -> Native Msg
carDetailEditView model car =
    Page.pageWithActionBar HandleFrameBack
        []
        (actionBar []
            [ navigationButton [ N.visibility "collapsed" ] []
            , label [ N.text "Edit Car Details", N.fontSize "18" ] []
            , actionItem
                [ N.text "Cancel"
                , N.iosPosition "left"
                , Event.onTap GoBack
                ]
                []
            , actionItem
                [ N.text "Done"
                , N.iosPosition "right"
                ]
                []
            ]
        )
        (scrollView [ N.class "car-list" ] <|
            Layout.flexboxLayout [ N.flexDirection "column" ]
                [ label [ N.text "CAR MAKE", N.class "car-list-odd" ] []
                , textField
                    [ N.text car.name
                    , N.hint "Car make field is required"
                    , N.class "car-list-even"
                    , Event.onTextChange (always NoOp)
                    ]
                    []
                , Layout.gridLayout
                    [ N.rows "*, 55, *"
                    , N.columns "*, auto"
                    , N.class "car-list-odd"
                    ]
                    [ label [ N.text "PRICE PER DAY" ] []
                    , label
                        [ N.col "1"
                        , N.horizontalAlignment "right"
                        , N.class "car-list__value"
                        ]
                        [ formattedString []
                            [ span [ N.text "€" ] []
                            , span [ N.text (String.fromInt car.price) ] []
                            ]
                        ]
                    , slider
                        [ N.row "1"
                        , N.colSpan "2"
                        , N.verticalAlignment "center"
                        , N.value (String.fromInt car.price)
                        ]
                        []
                    , label
                        [ N.text "ADD OR REMOVE IMAGE"
                        , N.row "2"
                        , N.colSpan "2"
                        ]
                        []
                    ]
                , Layout.stackLayout
                    [ N.class "car-list-even" ]
                    [ Layout.gridLayout
                        [ N.height "80"
                        , N.width "80"
                        , N.class "thumb"
                        , N.horizontalAlignment "left"
                        , N.backgroundImage car.imageUrl

                        -- , N.tap "onImageAddRemoveTap"
                        ]
                        [ Layout.gridLayout
                            [ N.class "thumb__add"
                            , N.visibility "collapsed"
                            ]
                            [ label
                                [ N.text (String.fromChar '\u{F030}')
                                , N.class "fas"
                                , N.horizontalAlignment "center"
                                , N.verticalAlignment "center"
                                ]
                                []
                            ]
                        , Layout.gridLayout
                            [ N.class "thumb__remove"
                            , N.visibility "visible"
                            ]
                            [ label
                                [ N.text (String.fromChar '\u{F2ED}')
                                , N.class "far"
                                , N.horizontalAlignment "center"
                                , N.verticalAlignment "center"
                                ]
                                []
                            ]
                        ]
                    , label
                        [ N.visibility "collapsed"
                        , N.class "c-error"
                        , N.text "Image field is required"
                        ]
                        []
                    ]
                , label [ N.text "CLASS", N.class "car-list-odd" ] []
                , Layout.gridLayout
                    [ N.columns "*, auto"
                    , N.class "car-list-even"

                    -- , N.tap "onSelectorTap"
                    ]
                    [ label [ N.text car.class ] []
                    , label
                        [ N.text (String.fromChar '\u{F054}')
                        , N.class "fas"
                        , N.col "1"
                        , N.horizontalAlignment "center"
                        , N.verticalAlignment "center"
                        ]
                        []
                    ]
                , label [ N.text "DOORS", N.class "car-list-odd" ] []
                , Layout.gridLayout
                    [ N.columns "*, auto"
                    , N.class "car-list-even"

                    -- , N.tap "onSelectorTap"
                    ]
                    [ label [ N.text (String.fromInt car.doors) ] []
                    , label
                        [ N.text (String.fromChar '\u{F054}')
                        , N.class "fas"
                        , N.col "1"
                        , N.horizontalAlignment "center"
                        , N.verticalAlignment "center"
                        ]
                        []
                    ]
                , label
                    [ N.text "SEATS"
                    , N.class "car-list-odd"
                    ]
                    []
                , Layout.gridLayout
                    [ N.columns "*, auto"
                    , N.class "car-list-even"

                    -- , N.tap "onSelectorTap"
                    ]
                    [ label [ N.text car.seats ] []
                    , label
                        [ N.text (String.fromChar '\u{F054}')
                        , N.class "fas"
                        , N.col "1"
                        , N.horizontalAlignment "center"
                        , N.verticalAlignment "center"
                        ]
                        []
                    ]
                , label
                    [ N.text "TRANSMISSION"
                    , N.class "car-list-odd"
                    ]
                    []
                , Layout.gridLayout
                    [ N.columns "*, auto"
                    , N.class "car-list-even"

                    -- , N.tap "onSelectorTap"
                    ]
                    [ label [ N.text car.transmission ] []
                    , label
                        [ N.text (String.fromChar '\u{F054}')
                        , N.class "fas"
                        , N.col "1"
                        , N.horizontalAlignment "center"
                        , N.verticalAlignment "center"
                        ]
                        []
                    ]
                , Layout.gridLayout
                    [ N.rows "*, 55"
                    , N.columns "*, auto"
                    , N.class "car-list-odd"
                    ]
                    [ label [ N.text "LUGGAGE" ] []
                    , label
                        [ N.col "1"
                        , N.horizontalAlignment "right"
                        , N.class "car-list__value"
                        ]
                        [ formattedString []
                            [ span [ N.text (String.fromInt car.luggage) ] []
                            , span [ N.text " Bag(s)" ] []
                            ]
                        ]
                    , slider
                        [ N.row "1"
                        , N.colSpan "2"
                        , N.minValue "0"
                        , N.maxValue "5"
                        , N.value (String.fromInt car.luggage)
                        ]
                        []
                    ]
                ]
        )


carDetailsEditPage : Model -> Native Msg
carDetailsEditPage model =
    case model.pickedCar of
        Nothing ->
            notFoundPage

        Just car ->
            carDetailEditView model car


carDetailView : Model -> Car -> Native Msg
carDetailView model car =
    Page.pageWithActionBar HandleFrameBack
        []
        (actionBar []
            [ navigationButton [ N.androidSystemIcon "ic_menu_back" ] []
            , label [ N.text car.name, N.fontSize "18" ] []
            , actionItem
                [ N.text "Edit"
                , N.iosSystemIcon "2"
                , N.iosPosition "right"
                , N.androidPosition "right"
                , Event.onTap ToCarDetailsEditPage
                ]
                []
            ]
        )
        (scrollView []
            (Layout.gridLayout [ N.rows "auto, auto, auto" ]
                [ image [ N.src car.imageUrl, N.class "m-b-15", N.stretch "aspectFill", N.height "200" ] []
                , Layout.stackLayout [ N.row "1", N.class "hr m-y-15" ] []
                , Layout.gridLayout [ N.row "2", N.rows "*, *, *, *, *, *", N.columns "auto, auto" ]
                    [ label [ N.text "Price", N.class "p-l-15 p-b-10 m-r-20" ] []
                    , label [ N.col "1", N.class "p-b-10" ]
                        [ formattedString []
                            [ span [ N.text "€" ] []
                            , span [ N.text (String.fromInt car.price) ] []
                            , span [ N.text "/day" ] []
                            ]
                        ]
                    , label [ N.text "Class", N.row "1", N.class "p-l-15 p-b-10 m-r-20" ] []
                    , label [ N.text car.class, N.row "1", N.col "1", N.class "p-b-10" ] []
                    , label [ N.text "Doors", N.row "2", N.class "p-l-15 p-b-10 m-r-20" ] []
                    , label [ N.text (String.fromInt car.doors), N.row "2", N.col "1", N.class "p-b-10" ] []
                    , label [ N.text "Seats", N.row "3", N.class "p-l-15 p-b-10 m-r-20" ] []
                    , label [ N.text car.seats, N.row "3", N.col "1", N.class "p-b-10" ] []
                    , label [ N.text "Transmission", N.row "4", N.class "p-l-15 p-b-10 m-r-20" ] []
                    , label [ N.text car.transmission, N.row "4", N.col "1", N.class "p-b-10" ] []
                    , label [ N.text "Luggage", N.row "5", N.class "p-l-15 p-b-10 m-r-20" ] []
                    , label [ N.text (String.fromInt car.luggage), N.row "5", N.col "1", N.class "p-b-10" ] []
                    ]
                ]
            )
        )


carDetailsPage : Model -> Native Msg
carDetailsPage model =
    case model.pickedCar of
        Nothing ->
            notFoundPage

        Just car ->
            carDetailView model car


carTemplate : Native Msg
carTemplate =
    Layout.gridLayout
        [ N.rows "*, *, *"
        , N.columns "*, *"
        , N.class "cars-list__item-content"
        ]
        [ label [ N.text <| bindingExpression " $value.name ", N.class "font-weight-bold cars-list__item-name" ] []
        , label [ N.col "1", N.horizontalAlignment "right" ]
            [ formattedString []
                [ span [ N.text "€" ] []
                , span [ N.text <| bindingExpression " $value.price " ] []
                , span [ N.text "/day" ] []
                ]
            ]
        , Layout.stackLayout [ N.row "1", N.class "hr m-y-5", N.colSpan "2" ] []
        , image
            [ N.row "2"
            , N.src <| bindingExpression " $value.imageUrl "
            , N.stretch "aspectFill"
            , N.height "120"
            ]
            []
        , Layout.stackLayout [ N.row "2", N.col "1", N.verticalAlignment "center" ]
            [ label [ N.class "p-b-10" ]
                [ formattedString [ N.fontFamily "system" ]
                    [ span [ N.text (String.fromChar '\u{F1B9}' ++ " "), N.class "fas fa-car cars-list__item-icon" ] []
                    , span [ N.text <| bindingExpression " $value.class " ] []
                    ]
                ]
            , label [ N.class "p-b-10" ]
                [ formattedString [ N.fontFamily "system" ]
                    [ span [ N.text (String.fromChar '\u{F085}' ++ " "), N.class "fas fa-car cars-list__item-icon" ] []
                    , span [ N.text <| bindingExpression " $value.transmission " ] []
                    , span [ N.text " Transmission" ] []
                    ]
                ]
            , label [ N.class "p-b-10" ]
                [ formattedString [ N.fontFamily "system" ]
                    [ span [ N.text (String.fromChar '\u{F2DC}' ++ " "), N.class "fas fa-car cars-list__item-icon" ] []
                    , span [ N.text <| bindingExpression " $value.hasAC ? 'Yes' : 'No' " ] []
                    ]
                ]
            ]
        ]


homePage : Model -> Native Msg
homePage model =
    Page.pageWithActionBar HandleFrameBack
        []
        (actionBar []
            [ label [ N.text "Browse", N.fontSize "18" ] []
            ]
        )
        (Layout.gridLayout []
            [ listView
                [ N.items model.encodedCars
                , N.separatorColor "transparent"
                , N.class "cars-list"
                , Event.onItemTap ToCarDetailsPage
                , Event.onEventWith
                    "itemLoading"
                    { methodCalls = []
                    , setters =
                        [ { keys = ( "ios", [ "selectionStyle" ] )
                          , assignmentValue =
                                dangerousEvalExpression " UITableViewCellSelectionStyle.None "
                          }
                        ]
                    }
                    (D.succeed NoOp)
                ]
                [ carTemplate ]
            ]
        )


view : Model -> Native Msg
view model =
    Frame.frame model.rootFrame
        model
        [ ( HomePage, homePage )
        , ( CarDetailsPage, carDetailsPage )
        , ( CarDetailsEditPage, carDetailsEditPage )
        ]
        []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
