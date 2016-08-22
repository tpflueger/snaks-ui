module Update.Update exposing (update)

import Model.Model exposing (Model)
import Update.Message exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
