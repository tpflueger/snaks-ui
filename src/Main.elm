module Main exposing (main)

import Color
import Task

import Html exposing (Html, div)
import Html.Attributes as Attr
import Html.App
import Window
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
    ( Model 0 0, getWindowSize )


getWindowSize : Cmd Msg
getWindowSize =
    Task.perform (\x -> NoOp) Resize Window.size
    
    
-- UPDATE


type Msg
    = NoOp
    | Resize Window.Size


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        Resize size ->
            ( { model | width = size.width, height = size.height }, Cmd.none )


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
    Window.resizes (\size -> Resize size)
