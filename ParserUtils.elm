module ParserUtils where

import String
-- this is separate only so that I can test these things


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