module Native.Event exposing (on)

import Html exposing (Attribute)
import Html.Events as Event
import Json.Decode as D


on : String -> D.Decoder msg -> Attribute msg
on eventName =
    Event.on eventName
{-
view Base

  "accessibilityBlurEvent",
  "accessibilityFocusChangedEvent",
  "accessibilityFocusEvent",
  "createdEvent",
  "layoutChangedEvent",
  "loadedEvent",
  "propertyChangeEvent",
  "showingModallyEvent",
  "shownModallyEvent",
  "unloadedEvent",
 -}
