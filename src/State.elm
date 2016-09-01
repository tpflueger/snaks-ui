module State exposing (init, update, subscriptions, mapSize, tileSize)

import Types exposing (Model, Msg(..), Snake, Vector)


mapSize : Int
mapSize =
    16


tileSize : Int
tileSize =
    16


init : ( Model, Cmd Msg )
init =
    Model mapSize mapSize initSnake ! [ Cmd.none ]


initSnake : Snake
initSnake =
    [ Vector 2 1, Vector 2 0, Vector 1 0, Vector 0 0 ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! [ Cmd.none ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
