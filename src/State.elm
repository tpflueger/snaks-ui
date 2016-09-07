module State exposing (init, update, subscriptions, mapSize, tileSize)

import Time exposing (second)
import Types exposing (Msg(..), Model, Snake, Vector, Direction(..))


mapSize : Int
mapSize =
    16


tileSize : Int
tileSize =
    16


init : ( Model, Cmd Msg )
init =
    Model mapSize mapSize initSnake ! []


initSnake : Snake
initSnake =
    [ Vector 3 3 North ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            moveSnake model ! []


moveSnake : Model -> Model
moveSnake model =
    case model.snake of
        head :: rest ->
            let
                head' =
                    moveSegment head
            in
                { model | snake = head' :: rest }

        _ ->
            model


moveSegment : Vector -> Vector
moveSegment { x, y, direction } =
    let
        ( x', y' ) =
            case direction of
                North ->
                    ( x, y + 1 )

                South ->
                    ( x, y - 1 )

                East ->
                    ( x + 1, y )

                West ->
                    ( x - 1, y )
    in
        Vector x' y' direction


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick
