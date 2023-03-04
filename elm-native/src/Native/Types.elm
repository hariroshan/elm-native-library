module Native.Types exposing
    ( CapitalizationType(..), InputType(..)
    , capitalizationToString, inputTypeToString
    )

{-| Type variants used in nativescript.


# Types

@docs CapitalizationType, InputType


# Functions

@docs capitalizationToString, inputTypeToString

-}


{-| Used to Capitalize Text
-}
type CapitalizationType
    = Sentences
    | None
    | All
    | Words


{-| Used for InputType
-}
type InputType
    = Text
    | Password
    | Email
    | Number
    | Decimal
    | Phone


{-| Converts InputType to string
-}
inputTypeToString : InputType -> String
inputTypeToString input =
    case input of
        Text ->
            "text"

        Password ->
            "password"

        Email ->
            "email"

        Number ->
            "number"

        Decimal ->
            "decimal"

        Phone ->
            "phone"


{-| Converts CapitalizationType to string
-}
capitalizationToString : CapitalizationType -> String
capitalizationToString cap =
    case cap of
        Sentences ->
            "sentences"

        None ->
            "none"

        All ->
            "all"

        Words ->
            "words"
