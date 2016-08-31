module View exposing (view)

import Color
import Html exposing (Html, div)
import Html.Attributes as Attr
import Collage exposing (Form)
import Element exposing (toHtml)
import Transform

import Types exposing (Model, Vector, Msg)
import State exposing (tileSize, mapSize)


(=>) : String -> String -> (String, String)
(=>) x y = (x, y)


view : Model -> Html Msg
view model =
  div [ Attr.style [ "width" => "100%", "height" => "100%" ] ]
    [ toHtml <|
        Collage.collage 500 500
          [ renderMap model
          , renderObjects model
          ]
    ]


renderObjects : Model -> Form
renderObjects model =
  List.map renderSegment model.snake
    |> translateObjects


renderMap : Model -> Form
renderMap model =
  let
    width = model.width * tileSize |> toFloat
    height = model.height * tileSize |> toFloat
  in
    Collage.rect width height
      |> Collage.filled Color.blue


renderSegment : Vector -> Form
renderSegment vector =
  let
    tileSize' = toFloat tileSize
    offsetX = tileSize * vector.x |> toFloat
    offsetY = tileSize * vector.y |> toFloat
    outline = 
      Collage.rect tileSize' tileSize'
        |> Collage.filled Color.white
    body =
      Collage.rect (tileSize' - 1) (tileSize' - 1)
        |> Collage.filled Color.red
  in
    Collage.group [ outline, body ]
      |> Collage.move (offsetX, offsetY)


translateObjects : List Form -> Form
translateObjects objects =
  let
    offset = -mapSize * tileSize // 2 + tileSize // 2 |> toFloat
    transformation = Transform.translation offset offset
  in
    Collage.groupTransform transformation objects
