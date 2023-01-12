module Native.Event exposing
    ( on
    , onBlur
    , onBusyChange
    , onDateChange
    , onEventWithMethodCalls
    , onFocus
    , onItemTap
    , onLoaded
    , onReturnPress
    , onSelectedIndexChange
    , onTap
    , onTextChange
    , onUnloaded
    )

import Html exposing (Attribute)
import Html.Events as Event
import Json.Decode as D


on : String -> D.Decoder msg -> Attribute msg
on eventName =
    Event.on eventName


{-| Method values are kept under {custom: {[methodName]: value}}
example:
Event.onEventWithMethodCalls "touch"
[ "getX", "getY" ]
(D.map2 Tuple.pair
(D.at [ "custom", "getX"] D.float)
(D.at [ "custom", "getY"] D.float)
|> D.map Msg
)
-}
onEventWithMethodCalls : String -> List String -> D.Decoder msg -> Attribute msg
onEventWithMethodCalls eventName methods =
    Event.on (eventName ++ ";" ++ String.join "," methods)


onTextChange : (String -> msg) -> Attribute msg
onTextChange msg =
    on "textChange" (D.field "value" D.string |> D.map msg)


onTap : msg -> Attribute msg
onTap msg =
    on "tap" (D.succeed msg)


onReturnPress : msg -> Attribute msg
onReturnPress msg =
    on "returnPress" (D.succeed msg)


onFocus : msg -> Attribute msg
onFocus msg =
    on "focus" (D.succeed msg)


onBlur : msg -> Attribute msg
onBlur msg =
    on "blur" (D.succeed msg)


onLoaded : msg -> Attribute msg
onLoaded msg =
    on "loaded" (D.succeed msg)


onUnloaded : msg -> Attribute msg
onUnloaded msg =
    on "unloaded" (D.succeed msg)


onBusyChange : msg -> Attribute msg
onBusyChange msg =
    on "busyChange" (D.succeed msg)


onDateChange : ({ day : Int, month : Int, year : Int } -> msg) -> Attribute msg
onDateChange msg =
    on "dateChange"
        (D.map3 (\day month year -> msg { day = day, month = month, year = year })
            (D.at [ "object", "day" ] D.int)
            (D.at [ "object", "month" ] D.int)
            (D.at [ "object", "year" ] D.int)
        )


onSelectedIndexChange : (Int -> msg) -> Attribute msg
onSelectedIndexChange msg =
    on "selectedIndexChange" (D.field "value" D.int |> D.map msg)


onItemTap : (Int -> msg) -> Attribute msg
onItemTap msg =
    on "itemTap" (D.field "index" D.int |> D.map msg)
