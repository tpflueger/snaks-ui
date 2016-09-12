module Main exposing (main)

import Html.App
import State
import View
import ViewSvg
import Html
import Html.Attributes as Attr


main : Program Never
main =
    Html.App.program
        { init = State.init
        , view =
            (\model ->
                Html.div [ Attr.style [ ( "display", "flex" ) ] ]
                    [ View.view model
                    , ViewSvg.view model
                    ]
            )
        , update = State.update
        , subscriptions = State.subscriptions
        }
