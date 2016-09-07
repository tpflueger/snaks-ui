module Types exposing (..)


mapSize : Int
mapSize =
    32


tileSize : Int
tileSize =
    14


tickLength : Float
tickLength =
    150


type Msg
    = Tick Float
    | UserInput UserAction


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


type UserAction
    = NoOp
    | Reset
    | ChangeDirection Direction
