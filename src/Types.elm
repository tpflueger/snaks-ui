module Types exposing (..)

import Keyboard exposing (KeyCode)


mapSize : Int
mapSize =
    16


tileSize : Int
tileSize =
    16


tickLength : Float
tickLength =
    150


type Msg
    = Tick Float
    | ChangeDirection KeyCode


type alias Model =
    { width : Int
    , height : Int
    , snake : Snake
    , delta : Float
    , collision : Bool
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
