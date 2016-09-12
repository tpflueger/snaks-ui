module State exposing (init, update, subscriptions)

import Char
import Random
import Time exposing (millisecond)
import Keyboard exposing (KeyCode)
import Extra.List as List
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    Model initSnake False Nothing ! [ getFoodCoord ]


initSnake : Snake
initSnake =
    [ Vector 3 3 North, Vector 3 2 North, Vector 3 1 North ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every (tickLength * millisecond) Tick
        , Keyboard.presses (UserInput << keyCodeToAction)
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick delta ->
            let
                foodCmd =
                    if model.food == Nothing then
                        getFoodCoord
                    else
                        Cmd.none
            in
                moveSnake model
                    ! [ foodCmd ]

        SpawnFood ( x, y ) ->
            { model | food = Just <| Food x y } ! []

        UserInput action ->
            case action of
                NoOp ->
                    model ! []

                Reset ->
                    init

                _ ->
                    { model
                        | snake =
                            changeSnakeDirection action model.snake
                    }
                        ! []


moveSnake : Model -> Model
moveSnake model =
    case model.snake of
        [] ->
            model

        head :: rest ->
            let
                head' =
                    newHead head
            in
                if collision rest head' then
                    { model | collision = True }
                else if foodCollision model.food head' then
                    { model
                        | food = Nothing
                        , snake = head' :: head :: rest
                    }
                else
                    { model
                        | snake =
                            head' :: head :: rest |> List.dropTail 1
                    }


foodCollision : Maybe Food -> Vector -> Bool
foodCollision food vector =
    case food of
        Nothing ->
            False

        Just { x, y } ->
            x == vector.x && y == vector.y


collision : List Vector -> Vector -> Bool
collision vectors { x, y } =
    let
        hitWall =
            x >= mapSize || x < 0 || y >= mapSize || y < 0

        hitSelf =
            List.any (\v -> x == v.x && y == v.y) vectors
    in
        hitWall || hitSelf


newHead : Vector -> Vector
newHead { x, y, direction } =
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


changeSnakeDirection : UserAction -> Snake -> Snake
changeSnakeDirection action snake =
    case snake of
        [] ->
            snake

        head :: tail ->
            let
                direction' =
                    case tail of
                        [] ->
                            head.direction

                        next :: _ ->
                            directionFromAction head.direction action
                                |> preventReverse head next
            in
                { head | direction = direction' } :: tail


directionFromAction : Direction -> UserAction -> Direction
directionFromAction default action =
    case action of
        ChangeDirection direction ->
            direction

        _ ->
            default


preventReverse : Vector -> Vector -> Direction -> Direction
preventReverse head next direction =
    case direction of
        North ->
            if head.y + 1 == next.y then
                head.direction
            else
                North

        South ->
            if head.y - 1 == next.y then
                head.direction
            else
                South

        East ->
            if head.x + 1 == next.x then
                head.direction
            else
                East

        West ->
            if head.x - 1 == next.x then
                head.direction
            else
                West


keyCodeToAction : KeyCode -> UserAction
keyCodeToAction keycode =
    case Char.fromCode keycode of
        'w' ->
            ChangeDirection North

        's' ->
            ChangeDirection South

        'd' ->
            ChangeDirection East

        'a' ->
            ChangeDirection West

        ' ' ->
            Reset

        _ ->
            NoOp


getFoodCoord : Cmd Msg
getFoodCoord =
    Random.pair (Random.int 1 30) (Random.int 1 30)
        |> Random.generate SpawnFood
