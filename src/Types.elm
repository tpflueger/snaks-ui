module Types exposing (..)

import Time exposing (Time)


type Msg
    = Tick Time


type alias Model =
    { width : Int
    , height : Int
    , snake : Snake
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
