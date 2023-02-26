module Native.Dialogs exposing
    ( Action
    , Alert
    , action
    , alert
    , confirm
    , defaultActionOption
    , defaultAlertOption
    , defaultConfirmOption
    , defaultLoginOption
    , login
    , prompt
    , setAndroidOnlyCancelable
    , setCancelButtonText
    , setCapitalizationType
    , setDefaultText
    , setInputType
    , setNeutralButtonText
    , setOkButtonText
    , setPassword
    , setPasswordHint
    , setTitle
    , setUserName
    , setUserNameHint, defaultPromptOption
    )

import Json.Decode as D
import Json.Encode as E
import Native.Types exposing (CapitalizationType(..), InputType(..), capitalizationToString, inputTypeToString)
import TaskPort exposing (FunctionName, QualifiedName, Task, callNS, inNamespace)


type alias Alert =
    { title : Maybe String
    , message : String
    , okButtonText : Maybe String
    , androidOnlyCancelable : Maybe Bool
    }


type alias Action =
    { title : Maybe String
    , message : String
    , cancelButtonText : String
    , actions : List String
    , androidOnlyCancelable : Maybe Bool
    }


type alias Confirm =
    { title : Maybe String
    , message : String
    , androidOnlyCancelable : Maybe Bool
    , okButtonText : Maybe String
    , neutralButtonText : Maybe String
    , cancelButtonText : Maybe String
    }


type alias Login =
    { title : Maybe String
    , message : String
    , okButtonText : Maybe String
    , cancelButtonText : Maybe String
    , neutralButtonText : Maybe String
    , userNameHint : Maybe String
    , passwordHint : Maybe String
    , userName : Maybe String
    , password : Maybe String
    }


type alias LoginResult =
    { username : String
    , password : String
    , result : Bool
    }


type alias Prompt =
    { title : Maybe String
    , message : String
    , okButtonText : Maybe String
    , cancelButtonText : Maybe String
    , neutralButtonText : Maybe String
    , defaultText : Maybe String
    , capitalizationType : Maybe CapitalizationType
    , inputType : Maybe InputType
    }


type alias PromptResult =
    { text : String
    , result : Bool
    }


defaultAlertOption : String -> Alert
defaultAlertOption message =
    { title = Nothing
    , message = message
    , okButtonText = Nothing
    , androidOnlyCancelable = Nothing
    }


defaultActionOption : String -> List String -> String -> Action
defaultActionOption message actions cancelButtonText =
    { title = Nothing
    , message = message
    , cancelButtonText = cancelButtonText
    , actions = actions
    , androidOnlyCancelable = Nothing
    }


defaultConfirmOption : String -> Confirm
defaultConfirmOption message =
    { title = Nothing
    , message = message
    , androidOnlyCancelable = Nothing
    , okButtonText = Nothing
    , neutralButtonText = Nothing
    , cancelButtonText = Nothing
    }


defaultLoginOption : String -> Login
defaultLoginOption message =
    { title = Nothing
    , message = message
    , okButtonText = Nothing
    , cancelButtonText = Nothing
    , neutralButtonText = Nothing
    , userNameHint = Nothing
    , passwordHint = Nothing
    , userName = Nothing
    , password = Nothing
    }


defaultPromptOption : String -> Prompt
defaultPromptOption message =
    { title = Nothing
    , message = message
    , okButtonText = Nothing
    , cancelButtonText = Nothing
    , neutralButtonText = Nothing
    , defaultText = Nothing
    , capitalizationType = Nothing
    , inputType = Nothing
    }


setTitle : String -> { a | title : Maybe String } -> { a | title : Maybe String }
setTitle title record =
    { record | title = Just title }


setOkButtonText : String -> { a | okButtonText : Maybe String } -> { a | okButtonText : Maybe String }
setOkButtonText okButtonText record =
    { record | okButtonText = Just okButtonText }


setCancelButtonText : String -> { a | cancelButtonText : Maybe String } -> { a | cancelButtonText : Maybe String }
setCancelButtonText cancelButtonText record =
    { record | cancelButtonText = Just cancelButtonText }


setNeutralButtonText : String -> { a | neutralButtonText : Maybe String } -> { a | neutralButtonText : Maybe String }
setNeutralButtonText neutralButtonText record =
    { record | neutralButtonText = Just neutralButtonText }


setDefaultText : String -> { a | defaultText : Maybe String } -> { a | defaultText : Maybe String }
setDefaultText defaultText record =
    { record | defaultText = Just defaultText }


setCapitalizationType : String -> { a | capitalizationType : Maybe String } -> { a | capitalizationType : Maybe String }
setCapitalizationType capitalizationType record =
    { record | capitalizationType = Just capitalizationType }


setInputType : String -> { a | inputType : Maybe String } -> { a | inputType : Maybe String }
setInputType inputType record =
    { record | inputType = Just inputType }


setUserNameHint : String -> { a | userNameHint : Maybe String } -> { a | userNameHint : Maybe String }
setUserNameHint userNameHint record =
    { record | userNameHint = Just userNameHint }


setUserName : String -> { a | userName : Maybe String } -> { a | userName : Maybe String }
setUserName userName record =
    { record | userName = Just userName }


setPasswordHint : String -> { a | passwordHint : Maybe String } -> { a | passwordHint : Maybe String }
setPasswordHint passwordHint record =
    { record | passwordHint = Just passwordHint }


setPassword : String -> { a | password : Maybe String } -> { a | password : Maybe String }
setPassword password record =
    { record | password = Just password }


setAndroidOnlyCancelable : Bool -> { a | androidOnlyCancelable : Maybe Bool } -> { a | androidOnlyCancelable : Maybe Bool }
setAndroidOnlyCancelable androidOnlyCancelable record =
    { record | androidOnlyCancelable = Just androidOnlyCancelable }


encodeCancelable : Bool -> ( String, E.Value )
encodeCancelable bool =
    ( "cancelable", E.bool bool )


encodeTitle : String -> ( String, E.Value )
encodeTitle title =
    ( "cancelable", E.string title )


encodeMessage : String -> ( String, E.Value )
encodeMessage message =
    ( "message", E.string message )


encodeOkButtonText : String -> ( String, E.Value )
encodeOkButtonText text =
    ( "okButtonText", E.string text )


encodeCancelButtonText : String -> ( String, E.Value )
encodeCancelButtonText text =
    ( "cancelButtonText", E.string text )


encodeNeutralButtonText : String -> ( String, E.Value )
encodeNeutralButtonText text =
    ( "neutralButtonText", E.string text )


encodeActions : List String -> ( String, E.Value )
encodeActions actions =
    ( "actions", E.list E.string actions )


filterMaybeEncode : List (Maybe ( String, E.Value )) -> E.Value
filterMaybeEncode =
    List.filterMap identity
        >> E.object


encodeAlert : Alert -> E.Value
encodeAlert alertOptions =
    [ alertOptions.title |> Maybe.map encodeTitle
    , Just (encodeMessage alertOptions.message)
    , alertOptions.okButtonText |> Maybe.map encodeOkButtonText
    , alertOptions.androidOnlyCancelable |> Maybe.map encodeCancelable
    ]
        |> filterMaybeEncode


encodeAction : Action -> E.Value
encodeAction actionOptions =
    [ actionOptions.title |> Maybe.map encodeTitle
    , actionOptions.message |> encodeMessage |> Just
    , actionOptions.actions |> encodeActions |> Just
    , actionOptions.cancelButtonText |> encodeCancelButtonText |> Just
    , actionOptions.androidOnlyCancelable |> Maybe.map encodeCancelable
    ]
        |> filterMaybeEncode


encodeConfirm : Confirm -> E.Value
encodeConfirm confirmOptions =
    [ confirmOptions.title |> Maybe.map encodeTitle
    , Just (encodeMessage confirmOptions.message)
    , confirmOptions.androidOnlyCancelable |> Maybe.map encodeCancelable
    , confirmOptions.okButtonText |> Maybe.map encodeOkButtonText
    , confirmOptions.neutralButtonText |> Maybe.map encodeNeutralButtonText
    , confirmOptions.cancelButtonText |> Maybe.map encodeCancelButtonText
    ]
        |> filterMaybeEncode


encodeLogin : Login -> E.Value
encodeLogin loginOptions =
    [ loginOptions.title |> Maybe.map encodeTitle
    , Just (encodeMessage loginOptions.message)
    , loginOptions.okButtonText |> Maybe.map encodeOkButtonText
    , loginOptions.cancelButtonText |> Maybe.map encodeCancelButtonText
    , loginOptions.neutralButtonText |> Maybe.map encodeNeutralButtonText
    , loginOptions.userNameHint |> Maybe.map (encodeStringWith "userNameHint")
    , loginOptions.passwordHint |> Maybe.map (encodeStringWith "passwordHint")
    , loginOptions.userName |> Maybe.map (encodeStringWith "userName")
    , loginOptions.password |> Maybe.map (encodeStringWith "password")
    ]
        |> filterMaybeEncode


decodeLoginResult : D.Decoder LoginResult
decodeLoginResult =
    D.map3 LoginResult
        (D.field "username" D.string)
        (D.field "password" D.string)
        (D.field "result" D.bool)


encodeCapitalizationType : CapitalizationType -> ( String, E.Value )
encodeCapitalizationType cap =
    ( "capitalizationType"
    , E.string <| capitalizationToString cap
    )


encodeInputType : InputType -> ( String, E.Value )
encodeInputType input =
    ( "inputType"
    , E.string <| inputTypeToString input
    )


encodeStringWith : String -> String -> ( String, E.Value )
encodeStringWith label value =
    ( label, E.string value )


encodePrompt : Prompt -> E.Value
encodePrompt promptOptions =
    [ promptOptions.title |> Maybe.map encodeTitle
    , Just (encodeMessage promptOptions.message)
    , promptOptions.okButtonText |> Maybe.map encodeOkButtonText
    , promptOptions.cancelButtonText |> Maybe.map encodeCancelButtonText
    , promptOptions.neutralButtonText |> Maybe.map encodeNeutralButtonText
    , promptOptions.capitalizationType |> Maybe.map encodeCapitalizationType
    , promptOptions.inputType |> Maybe.map encodeInputType
    , promptOptions.defaultText |> Maybe.map (encodeStringWith "defaultText")
    ]
        |> filterMaybeEncode


decodePromptResult : D.Decoder PromptResult
decodePromptResult =
    D.map2 PromptResult
        (D.field "text" D.string)
        (D.field "result" D.bool)


taskportNamespace : FunctionName -> QualifiedName
taskportNamespace =
    inNamespace "hariroshan/elm-native" "v1"


alert : Alert -> Task ()
alert =
    callNS
        { function = "DialogsAlert" |> taskportNamespace
        , valueDecoder = D.succeed ()
        , argsEncoder = encodeAlert
        }


action : Action -> Task String
action =
    callNS
        { function = "DialogsAction" |> taskportNamespace
        , valueDecoder = D.string
        , argsEncoder = encodeAction
        }


confirm : Confirm -> Task Bool
confirm =
    callNS
        { function = "DialogsConfirm" |> taskportNamespace
        , valueDecoder = D.bool
        , argsEncoder = encodeConfirm
        }


login : Login -> Task LoginResult
login =
    callNS
        { function = "DialogsLogin" |> taskportNamespace
        , valueDecoder = decodeLoginResult
        , argsEncoder = encodeLogin
        }


prompt : Prompt -> Task PromptResult
prompt =
    callNS
        { function = "DialogsPrompt" |> taskportNamespace
        , valueDecoder = decodePromptResult
        , argsEncoder = encodePrompt
        }
