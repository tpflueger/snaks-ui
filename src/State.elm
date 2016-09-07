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
    Model mapSize mapSize initSnake ! []


initSnake : Snake
initSnake =
    [ Vector 3 3 ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
