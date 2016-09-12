module ViewSvg exposing (view)

import Svg exposing (Svg, Attribute)
import Svg.Attributes as SvgA
import Html exposing (Html, div, text)
import Html.Attributes as HtmlA
import Types exposing (Msg, Model, Vector, mapSize, tileSize)


mapSizePx : Int
mapSizePx =
    mapSize * tileSize


width : Int -> Attribute Msg
width w =
    toString w |> SvgA.width


height : Int -> Attribute Msg
height h =
    toString h |> SvgA.height


offsetX : Int -> Attribute Msg
offsetX x =
    x * tileSize |> toString |> SvgA.x


offsetY : Int -> Attribute Msg
offsetY y =
    y * tileSize |> toString |> SvgA.y


square : Int -> List (Attribute Msg) -> List (Svg Msg) -> Svg Msg
square dim attr children =
    let
        attr' =
            width dim :: height dim :: attr
    in
        Svg.rect attr' children


view : Model -> Html Msg
view model =
    div [ HtmlA.class "game-container" ]
        [ Svg.svg [ width mapSizePx, height mapSizePx ]
            [ renderMap model
            , renderObjects model
            ]
        ]


renderMap : Model -> Svg Msg
renderMap model =
    square mapSizePx [ SvgA.fill "#3465a4" ] []


renderObjects : Model -> Svg Msg
renderObjects model =
    Svg.g
        [ "translate(0, "
            ++ toString mapSizePx
            ++ ") scale(1, -1)"
            |> SvgA.transform
        ]
        [ renderSnake model, renderFood model ]


renderSnake : Model -> Svg Msg
renderSnake model =
    let
        color =
            if model.collision then
                "#cc0000"
            else
                "#73d216"
    in
        List.map (renderSegment color) model.snake
            |> Svg.g []


renderSegment : String -> Vector -> Svg Msg
renderSegment color vector =
    square tileSize
        [ offsetX vector.x
        , offsetY vector.y
        , SvgA.fill color
        , SvgA.stroke "#eeeeec"
        , SvgA.strokeWidth "1"
        ]
        []


renderFood : Model -> Svg Msg
renderFood model =
    case model.food of
        Nothing ->
            Svg.g [] []

        Just vector ->
            square tileSize
                [ offsetX vector.x
                , offsetY vector.y
                , SvgA.fill "#edd400"
                ]
                []
