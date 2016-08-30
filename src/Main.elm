module Main exposing (main)

import Html.App

import Model.Model as Model exposing (Model, Snake, Vector)
import Update.Message exposing (Msg)
import Update.Update as Update
import View.View as View


-- MAIN


main : Program Never
main =
  Html.App.program
    { init = Model.init
    , view = View.view
    , update = Update.update
    , subscriptions = subscriptions
    }


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
