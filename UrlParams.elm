module UrlParams where

import Html exposing (Html)
import Dict exposing (Dict)
import String

--- MODEL
type Model = 
    Error String
  | UrlParams (Dict String String)

model = parseSearchString windowLocationSearch

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

--- functions
parseSearchString : String -> Model
parseSearchString startsWithQuestionMarkThenParams =
  case (String.uncons startsWithQuestionMarkThenParams) of
    Nothing -> Error "No URL params"
    Just ('?', rest) -> parseParams rest

parseParams : String -> Model
parseParams stringWithAmpersands =
  let
    eachParam = (String.split "&" stringWithAmpersands)
    eachPair  = List.map (splitAtFirst '=') eachParam
  in
    Error ("Got: " ++ (String.join ", " (List.map toString eachPair)))


splitAtFirst : Char -> String -> (String, String)
splitAtFirst c s =
  case (firstOccurrence c s) of
    Nothing -> (s, "")
    Just i  -> ((String.left i s), (String.dropLeft (i + 1) s))


firstOccurrence : Char -> String -> Maybe Int 
firstOccurrence c s = 
  case (String.indexes (toString c) s) of
    []        -> Nothing
    head :: _ -> Just head
