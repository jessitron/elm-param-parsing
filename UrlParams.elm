module UrlParams where

import ParameterTable exposing (view, init)
import Html exposing (Html)

main : Html
main = view (init windowLocationSearch)

port windowLocationSearch : String

