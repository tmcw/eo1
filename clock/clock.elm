import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Time exposing (..)
import Bitwise exposing (..)
import Text exposing (..)
import Array exposing (..)
import List exposing (head, append)
import String exposing (join)
import Transform2D exposing (translation)

main =
  Signal.map clock (every second)
  
width = 1440
height = 2560
  
getBit t offset = (shiftRightLogical
  (shiftLeft (round t) offset) 31) == 1
  
clearGrey =
  rgba 50 50 50 0.5

lightGrey =
  rgba 100 100 100 0.5
    
gapX = 280
gapY = 280
perline = 4
margin = 300

toCoordinates place = (
  toFloat ((place % perline) * gapX),
  (toFloat (-(floor ((toFloat place) / perline)) * gapY)))

clock t =
  collage width height
    (List.append
      [filled black (rect width height)]
      [
        (groupTransform
          (Transform2D.translation ((-width / 2) + margin) ((height / 2) - margin))
          (List.map
            (\(place) ->
              (circle 300 
                |> filled (if (getBit t place) then lightGrey else clearGrey)
                |> move (toCoordinates (place))))
             (List.map round [0..31])))
      ])
