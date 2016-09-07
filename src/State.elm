module State exposing (init, update, subscriptions, mapSize, tileSize)

import Char
import AnimationFrame
import Time exposing (millisecond)
import Keyboard exposing (KeyCode)
import Types exposing (Msg(..), Model, Snake, Vector, Direction(..))


mapSize : Int
mapSize =
    16


tileSize : Int
tileSize =
    16


tickLength : Float
tickLength =
    150


init : ( Model, Cmd Msg )
init =
    Model mapSize mapSize initSnake 0 ! []


initSnake : Snake
initSnake =
    [ Vector 3 3 North, Vector 3 2 North, Vector 3 1 North ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ AnimationFrame.diffs Tick
        , Keyboard.presses ChangeDirection
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

        ChangeDirection keycode ->
            { model | snake = changeSnakeDirection keycode model.snake } ! []


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
    if model.delta == 0 then
        case model.snake of
            [] ->
                model

            head :: rest ->
                { model | snake = newHead head :: head :: removeTail rest }
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


removeTail : List Vector -> List Vector
removeTail vectors =
    case vectors of
        head :: [] ->
            []

        head :: tail ->
            head :: removeTail tail

        _ ->
            []


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
