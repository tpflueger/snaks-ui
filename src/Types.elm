module Types exposing (..)


mapSize : Int
mapSize =
    32


tileSize : Int
tileSize =
    14


tickLength : Float
tickLength =
    125


type Msg
    = Tick Float
    | UserInput UserAction
    | SpawnFood ( Int, Int )


type alias Model =
    { snake : Snake
    , delta : Float
    , collision : Bool
    , food : Maybe Food
    }


type alias Snake =
    List Vector


type alias Vector =
    { x : Int
    , y : Int
    , direction : Direction
    }


type alias Food =
    { x : Int
    , y : Int
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
