module Extra.List exposing (dropTail)


dropTail : Int -> List a -> List a
dropTail n items =
    items
        |> List.reverse
        |> List.drop n
        |> List.reverse
