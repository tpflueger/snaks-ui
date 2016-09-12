module View exposing (view)

import Color exposing (Color)
import Html exposing (Html, div, text)
import Html.Attributes as Attr
import Collage exposing (Form, collage)
import Element exposing (toHtml)
import Transform
import Types exposing (Model, Vector, Msg, tileSize, mapSize)


mapSizePx : Int
mapSizePx =
    mapSize * tileSize


getOffset : Int -> Int -> ( Float, Float )
getOffset x y =
    ( tileSize * x |> toFloat, tileSize * y |> toFloat )


view : Model -> Html Msg
view model =
    div [ Attr.class "game-container" ]
        [ toHtml <|
            collage mapSizePx
                mapSizePx
                [ renderMap model
                , renderObjects model
                ]
        , div [] [ text "Control snake with WASD." ]
        , div [] [ text "Press [Space] to reset." ]
        ]


renderMap : Model -> Form
renderMap model =
    toFloat mapSizePx
        |> Collage.square
        |> Collage.filled Color.blue


renderObjects : Model -> Form
renderObjects model =
    [ renderSnake model, renderFood model ]
        |> translateObjects


renderSnake : Model -> Form
renderSnake model =
    let
        color =
            if model.collision then
                Color.red
            else
                Color.green
    in
        List.map (renderSegment color) model.snake
            |> Collage.group


renderSegment : Color -> Vector -> Form
renderSegment color vector =
    let
        outline =
            toFloat tileSize
                |> Collage.square
                |> Collage.filled Color.white

        body =
            toFloat tileSize
                - 1
                |> Collage.square
                |> Collage.filled color
    in
        Collage.group [ outline, body ]
            |> Collage.move (getOffset vector.x vector.y)


renderFood : Model -> Form
renderFood model =
    case model.food of
        Nothing ->
            Collage.square 0
                |> Collage.filled Color.blue

        Just { x, y } ->
            toFloat tileSize
                |> Collage.square
                |> Collage.filled Color.yellow
                |> Collage.move (getOffset x y)


translateObjects : List Form -> Form
translateObjects objects =
    let
        offset =
            -mapSizePx // 2 + tileSize // 2 |> toFloat

        transformation =
            Transform.translation offset offset
    in
        Collage.groupTransform transformation objects
