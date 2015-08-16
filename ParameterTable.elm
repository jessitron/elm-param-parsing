module ParameterTable(view, init) where

import Html exposing (Html)
import Html.Attributes as Attr
import Dict exposing (Dict)
import String

import ParserUtils exposing (splitAtFirst, firstOccurrence)

--- MODEL
type Model = 
    Error String
  | UrlParams (Dict String String)


init: String -> Model
init windowLocationSearch = parseSearchString windowLocationSearch

--- VIEW 
view : Model -> Html
view model =  
  case model of
    Error msg -> Html.h2 [] [Html.text msg]
    UrlParams dict -> Html.div [ Attr.style [("margin", "20px")]] 
      [
        Html.h2 [] [Html.text "URL Parameter Parsing in Elm"],
        paramsTable dict
      ]

tableClassFromPureCss = "pure-table"

--- view construction functions
paramsTable : Dict String String -> Html
paramsTable dict = Html.table [ Attr.class tableClassFromPureCss ] 
      ((Html.thead [] [row ("Key", "Value")]) :: (List.map row (Dict.toList dict)))

row : (String, String) -> Html
row (k, v) = Html.tr [] [(Html.td [] [Html.text k]), (Html.td [] [Html.text v])]


--- functions for parsing

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
    UrlParams (Dict.fromList eachPair)