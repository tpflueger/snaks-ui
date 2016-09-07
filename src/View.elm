module View exposing (view)

import Color exposing (Color)
import Html exposing (Html, div)
import Html.Attributes as Attr
import Collage exposing (Form)
import Element exposing (toHtml)
import Transform
import Types exposing (Model, Vector, Msg, tileSize, mapSize)


view : Model -> Html Msg
view model =
    div [ Attr.class "game-container" ]
        [ toHtml <|
            Collage.collage 500
                500
                [ renderMap model
                , renderObjects model
                ]
        ]


renderObjects : Model -> Form
renderObjects model =
    let
        color =
            if model.collision then
                Color.red
            else
                Color.green
    in
        List.map (renderSegment color) model.snake
            |> translateObjects


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


renderSegment : Color -> Vector -> Form
renderSegment color vector =
    let
        tileSize' =
            toFloat tileSize

        offsetX =
            tileSize * vector.x |> toFloat

        offsetY =
            tileSize * vector.y |> toFloat

        outline =
            Collage.rect tileSize' tileSize'
                |> Collage.filled Color.white

        body =
            Collage.rect (tileSize' - 1) (tileSize' - 1)
                |> Collage.filled color
    in
        Collage.group [ outline, body ]
            |> Collage.move ( offsetX, offsetY )


translateObjects : List Form -> Form
translateObjects objects =
    let
        offset =
            -mapSize * tileSize // 2 + tileSize // 2 |> toFloat

        transformation =
            Transform.translation offset offset
    in
        Collage.groupTransform transformation objects
