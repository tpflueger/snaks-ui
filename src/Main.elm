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
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )


-- MESSAGES


type Msg
    = NoOp


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
    
    
-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


-- VIEW


(=>) : String -> String -> (String, String)
(=>) attribute value = (attribute, value)


view : Model -> Html Msg
view model =
    div [ Attr.style [ "width" => "100%", "height" => "100%" ] ]
        [ toHtml <|
            collage 100 100
                [ Coll.filled Color.blue <| Coll.rect 100 100 ]
        ]