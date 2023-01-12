module Native.Frame exposing (Model, back, frame, init, current)

import Html exposing (Attribute, Html)


type alias Model page =
    { current : page, history : List page }


cons : List a -> a -> List a
cons acc x =
    x :: acc


frame : Model page -> model -> List ( page, model -> Html msg ) -> List (Attribute msg) -> Html msg
frame model appModel pages attrs =
    let
        children =
            pages
                |> getPage model.current appModel
                |> Maybe.map List.singleton
                |> Maybe.withDefault []

        history =
            model.history
                |> List.foldl
                    (\old acc ->
                        pages
                            |> getPage old appModel
                            |> Maybe.map (cons acc)
                            |> Maybe.withDefault acc
                    )
                    children

        -- _ =
        --     Debug.log "Childenr" (List.length history)
    in
    (Html.node "ns-frame"
        attrs
        history
     -- model.history
     -- |> List.foldl
     --     (\next acc ->
     --     )
     --     []
     -- ([ pages
     --     |> getPage model.current model
     --  , model.next
     --     |> Maybe.map
     --         (\next ->
     --             pages
     --                 |> getPage next model
     --         )
     --     |> Maybe.withDefault []
     --  ]
     --     |> List.concat
     -- )
    )



-- frame : List (Attribute msg) -> List (Html msg) -> Html msg
-- frame attrs nodes =
--     Html.node "ns-frame"
--         attrs
--         nodes


getPage : a -> b -> List ( a, b -> Html msg ) -> Maybe (Html msg)
getPage target model pages =
    pages
        |> findInList target Tuple.first Nothing
        |> Maybe.map
            (\( _, fx ) ->
                model
                    |> fx
            )


findInList : b -> (a -> b) -> Maybe a -> List a -> Maybe a
findInList target toItem acc ls =
    case ls of
        [] ->
            acc

        h :: r ->
            if target == toItem h then
                Just h

            else
                findInList target toItem acc r


init : page -> Model page
init currentPage =
    { current = currentPage
    , history = []
    }


back : Bool -> Model page -> Model page
back bool model =
    if not bool then
        model

    else
        case model.history of
            [] ->
                model

            cur :: [] ->
                { model | history = [], current = cur }

            _ :: cur :: rest ->
                { model | history = rest, current = cur }


current : page -> Model page -> Model page
current page model =
    { model
        | history = model.current :: model.history
        , current = page
    }
