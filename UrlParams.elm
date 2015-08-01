module UrlParams where

import Html exposing (Html)
import Dict exposing (Dict)
import String

main : Html
main = Html.text windowLocationSearch

port windowLocationSearch : String
