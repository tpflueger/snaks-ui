module Main exposing (main)

import Color

import Html exposing (Html, div)
import Html.Attributes as Attr
import Html.App
import Collage exposing (Form)
import Element exposing (toHtml)
import Transform


-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- MODEL


type alias Model =
    { width : Int
    , height : Int
    , snake : Snake
    }


type alias Snake =
    List Vector


type alias Vector =
    { x : Int
    , y : Int
    }


mapSize : Int
mapSize = 16


init : ( Model, Cmd Msg )
init =
    ( Model mapSize mapSize initSnake, Cmd.none )


initSnake : Snake
initSnake =
    [ Vector 2 1, Vector 2 0, Vector 1 0, Vector 0 0 ]


-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


-- VIEW


tileSize : Int
tileSize = 16


(=>) : String -> String -> (String, String)
(=>) x y = (x, y)


view : Model -> Html Msg
view model =
    div [ Attr.style [ "width" => "100%", "height" => "100%" ] ]
        [ toHtml <|
            Collage.collage 500 500 <|
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
        offset = toFloat <| -mapSize * tileSize // 2 + tileSize // 2
        transformation = Transform.translation offset offset
    in
        Collage.groupTransform transformation objects


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
