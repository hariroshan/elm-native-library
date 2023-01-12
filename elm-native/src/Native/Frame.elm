module Native.Frame exposing (Model, frame)

import Html exposing (Attribute, Html)


type alias Model a page =
    { a | current : page, next : Maybe page, history : List page }


cons : List a -> a -> List a
cons acc x =
    x :: acc


frame : Model a page -> List ( page, Model a page -> Html msg ) -> List (Attribute msg) -> Html msg
frame model pages attrs =
    let
        children =
            pages
                |> getPage model.current model
                |> Maybe.map List.singleton
                |> Maybe.withDefault []

        history =
            model.history
                |> List.foldl
                    (\old acc ->
                        pages
                            |> getPage old model
                            |> Maybe.map (cons acc)
                            |> Maybe.withDefault acc
                    )
                    children

        _ =
            Debug.log "Childenr" (List.length history)
    in
    (Html.node "ns-frame"
        attrs
        (history
         -- model.history
         -- |> List.foldl
         --     (\next acc ->
         --     )
         --     []
        )
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



-- root : Frame msg -> Html msg
-- root (Frame e) =
--     e
-- asElement : Frame msg -> Html msg
-- asElement =
--     root
