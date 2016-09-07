module View exposing (view)

import Color exposing (Color)
import Html exposing (Html, div, text)
import Html.Attributes as Attr
import Collage exposing (Form)
import Element exposing (toHtml)
import Transform
import Types exposing (Model, Vector, Msg, tileSize, mapSize)


mapSizePx : Int
mapSizePx =
    mapSize * tileSize


view : Model -> Html Msg
view model =
    div [ Attr.class "game-container" ]
        [ toHtml <|
            Collage.collage mapSizePx
                mapSizePx
                [ renderMap model
                , renderSnake model
                , [ renderFood model ] |> translateObjects
                ]
        , text "Press [Space] to reset."
        ]


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


renderMap : Model -> Form
renderMap model =
    let
        width =
            model.width * tileSize |> toFloat

        height =
            model.height * tileSize |> toFloat
    in
        Collage.rect width height
            |> Collage.filled Color.blue


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
            |> translateObjects


renderSegment : Color -> Vector -> Form
renderSegment color vector =
    let
        tileSize' =
            toFloat tileSize

        outline =
            Collage.rect tileSize' tileSize'
                |> Collage.filled Color.white

        body =
            Collage.rect (tileSize' - 1) (tileSize' - 1)
                |> Collage.filled color
    in
        Collage.group [ outline, body ]
            |> Collage.move (getOffset vector.x vector.y)


translateObjects : List Form -> Form
translateObjects objects =
    let
        offset =
            -mapSizePx // 2 + tileSize // 2 |> toFloat

        transformation =
            Transform.translation offset offset
    in
        Collage.groupTransform transformation objects


getOffset : Int -> Int -> ( Float, Float )
getOffset x y =
    ( tileSize * x |> toFloat, tileSize * y |> toFloat )
