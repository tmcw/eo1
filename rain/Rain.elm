import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Time exposing (Time, millisecond)
import Basics exposing (sin)
import Random
import Element
import Collage
import Color exposing (Color)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL
type alias Model = Time

init : (Model, Cmd Msg)
init =
  (0, Cmd.none)

-- UPDATE
type Msg
  = Tick Time

createFuture : Random.Generator (List Int)
createFuture =
  Random.list 500 (Random.int 0 500)

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Tick newTime ->
      (newTime, Cmd.none)

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every millisecond Tick

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ Collage.collage 500 500
      [
        Collage.filled (Color.rgb 200 100 20) (Collage.rect (((sin (model / 100)) * 10) + 100) 20)
      ]
      |> Element.toHtml
    ]
