module Native.Attributes exposing (text)

import Html exposing (Attribute)
import Html.Attributes exposing (attribute)


text : String -> Attribute msg
text =
    attribute "text"
