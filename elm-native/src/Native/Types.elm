module Native.Types exposing
    ( CapitalizationType(..)
    , InputType(..)
    , capitalizationToString
    , inputTypeToString
    )


type CapitalizationType
    = Sentences
    | None
    | All
    | Words


type InputType
    = Text
    | Password
    | Email
    | Number
    | Decimal
    | Phone


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
