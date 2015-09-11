module UrlParameterParser(ParseResult(..), parseSearchString, splitAtFirst, firstOccurrence) where

import Dict exposing (Dict)
import String

{-|
  If parsing is successful, you get a UrlParams containing a dictionary of keys to values.
  Otherwise, an error string.
  If there are no parameters, you'll get an error description.
 -}
type ParseResult = 
    Error String
  | UrlParams (Dict String String)

{-|
  Given a search string of the form "?key=value&key2=val2"
  parse these into a dictionary of key to value.
 -}
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