module Main exposing (main)

import Html.App

import State
import View


-- MAIN


main : Program Never
main =
  Html.App.program
    { init = State.init
    , view = View.view
    , update = State.update
    , subscriptions = State.subscriptions
    }
