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
  Signal.map clock (every millisecond)
  
width = 1440
height = 2560
  
getBit t offset = (shiftRightLogical
  (shiftLeft (round t) offset) 31) == 1
  
clearGrey =
  rgba 50 50 50 0.5

lightGrey =
  rgba 100 100 100 0.5
    
gap = 233
perline = 6
margin = 116

toCoordinates place = (
  toFloat ((place % perline) * gap),
  (toFloat (-(floor ((toFloat place) / perline)) * gap)))

clock t =
  collage width height
    (List.append
      [filled black (rect width height)]
      [
        (groupTransform
          (Transform2D.translation ((-width / 2) + margin) ((height / 2) - margin))
          (List.map
            (\(place) ->
              (circle 160 
                |> filled (if (getBit t place) then lightGrey else clearGrey)
                |> move (toCoordinates (place))))
             (List.map round [0..63])))
      ])
