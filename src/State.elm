module State exposing (init, update, subscriptions)

import Char
import String
import AnimationFrame
import Time exposing (millisecond)
import Keyboard exposing (KeyCode)
import Extra.List as List
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    Model mapSize mapSize initSnake 0 False ! []


initSnake : Snake
initSnake =
    [ Vector 3 3 North, Vector 3 2 North, Vector 3 1 North ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ AnimationFrame.diffs Tick
        , Keyboard.presses UserInput
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick delta ->
            (model
                |> sync delta
                |> moveSnake
            )
                ! []

        UserInput keycode ->
            let
                str =
                    Char.fromCode keycode
                        |> String.fromChar
            in
                if String.contains str "wasd" then
                    { model
                        | snake =
                            changeSnakeDirection keycode model.snake
                    }
                        ! []
                else
                    init


sync : Float -> Model -> Model
sync delta model =
    let
        delta' =
            model.delta + delta
    in
        if Time.inMilliseconds delta' > tickLength then
            { model | delta = 0 }
        else
            { model | delta = delta' }


moveSnake : Model -> Model
moveSnake model =
    if not model.collision && model.delta == 0 then
        case model.snake of
            [] ->
                model

            head :: rest ->
                let
                    head' =
                        newHead head
                in
                    if
                        (head'.x >= mapSize)
                            || (head'.x < 0)
                            || (head'.y >= mapSize)
                            || (head'.y < 0)
                    then
                        { model | snake = head :: rest, collision = True }
                    else
                        { model
                            | snake =
                                head' :: head :: rest |> List.dropTail 1
                        }
    else
        model


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


changeSnakeDirection : KeyCode -> Snake -> Snake
changeSnakeDirection keycode snake =
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
                            keyToDirection head.direction keycode
                                |> preventReverse head next
            in
                { head | direction = direction' } :: tail


keyToDirection : Direction -> KeyCode -> Direction
keyToDirection default keycode =
    case Char.fromCode keycode of
        'w' ->
            North

        's' ->
            South

        'd' ->
            East

        'a' ->
            West

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
