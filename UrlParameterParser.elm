module UrlParameterParser(ParseResult(..), parseSearchString, splitAtFirst, firstOccurrence) where

import Dict exposing (Dict)
import String

type ParseResult = 
    Error String
  | UrlParams (Dict String String)

parseSearchString : String -> ParseResult
parseSearchString startsWithQuestionMarkThenParams =
  case (String.uncons startsWithQuestionMarkThenParams) of
    Nothing -> Error "No URL params"
    Just ('?', rest) -> parseParams rest

parseParams : String -> ParseResult
parseParams stringWithAmpersands =
  let
    eachParam = (String.split "&" stringWithAmpersands)
    eachPair  = List.map (splitAtFirst '=') eachParam
  in
    UrlParams (Dict.fromList eachPair)


-- these are exposed only so that I can test these things

splitAtFirst : Char -> String -> (String, String)
splitAtFirst c s =
  case (firstOccurrence c s) of
    Nothing -> (s, "")
    Just i  -> ((String.left i s), (String.dropLeft (i + 1) s))


firstOccurrence : Char -> String -> Maybe Int 
firstOccurrence c s = 
  case (String.indexes (String.fromChar c) s) of
    []        -> Nothing
    head :: _ -> Just head