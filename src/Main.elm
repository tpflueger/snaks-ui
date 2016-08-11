module Main exposing (main)

import Color

import Html exposing (Html, div)
import Html.Attributes as Attr
import Html.App
import Collage as Coll exposing (collage)
import Element exposing (toHtml)


-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- MODEL


type alias Model =
    { width : Int
    , height : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 0, Cmd.none )


-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


-- VIEW


(=>) : String -> String -> (String, String)
(=>) x y = (x, y)


view : Model -> Html Msg
view model =
    div [ Attr.style [ "width" => "100%", "height" => "100%" ] ]
        [ toHtml <|
            collage model.width model.height
                [ Coll.filled Color.blue <| Coll.rect (toFloat model.width) (toFloat model.height) ]
        ]


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
