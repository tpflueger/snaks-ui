module Main exposing (main)

import Html exposing (Html)
import Html.Attributes
import Html.App
import Svg exposing (svg, circle)
import Svg.Attributes as Attr


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
    svg []
        [ circle
            [ Attr.cx "50"
            , Attr.cy "50"
            , Attr.r "45"
            , Attr.fill "#0B79CE"
            ] []
        ]