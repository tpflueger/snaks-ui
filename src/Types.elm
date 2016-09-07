module Types exposing (..)

import Keyboard exposing (KeyCode)


type Msg
    = Tick Float
    | ChangeDirection KeyCode


type alias Model =
    { width : Int
    , height : Int
    , snake : Snake
    , delta : Float
    }


type alias Snake =
    List Vector


type alias Vector =
    { x : Int
    , y : Int
    , direction : Direction
    }


type Direction
    = North
    | South
    | East
    | West
