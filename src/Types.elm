module Types exposing (..)


type Msg
  = NoOp


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
  }
