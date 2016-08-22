module Model.Model exposing (Model, Snake, Vector, init)

import Model.Constants exposing (mapSize)
import Update.Message exposing (Msg)


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


init : ( Model, Cmd Msg )
init =
  ( Model mapSize mapSize initSnake, Cmd.none )


initSnake : Snake
initSnake =
  [ Vector 2 1, Vector 2 0, Vector 1 0, Vector 0 0 ]
