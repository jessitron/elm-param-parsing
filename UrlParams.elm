module UrlParams where

import Html exposing (Html)
import Dict exposing (Dict)
import String

--- MODEL
type Model = 
    Error String
  | UrlParams (Dict String String)

model = Error windowLocationSearch

--- VIEW 
view : Model -> Html
view model = 
  case model of
    Error msg -> Html.h2 [] [Html.text msg]
    UrlParams _ -> Html.text "Not implemented"

--- wiring
main : Html
main = view model

port windowLocationSearch : String