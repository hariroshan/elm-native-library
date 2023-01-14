module Details exposing (..)

import Browser
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


type alias Model =
    { rootFrame : Frame.Model NavPage
    , cars : List Car
    , encodedCars : E.Value
    }


type Msg
    = Back Bool
    | NoOp


init : ( Model, Cmd Msg )
init =
    ( { rootFrame = Frame.init HomePage
      , cars = response
      , encodedCars =
            encodeCars response
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Back bool ->
            ( { model | rootFrame = Frame.back bool model.rootFrame }, Cmd.none )


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
        , image [ N.row "2", N.src <| bindingExpression " $value.imageUrl ", N.stretch "aspectFill", N.height "120" ] [] -- , N.class "m-r-15"
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
    Page.pageWithActionBar Back
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
                , Event.onEventWith
                    "itemLoading"
                    []
                    [ { keys = [ "ios", "selectionStyle" ]
                      , assignmentValue =
                            dangerousEvalExpression " UITableViewCellSelectionStyle.None "
                      }
                    ]
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
        ]
        []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
