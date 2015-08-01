module Main where

import ParserUtils as Subject
import List

import ElmTest.Assertion as A
import ElmTest.Run as R
import ElmTest.Runner.Console exposing (runDisplay)
import ElmTest.Test exposing (..)

import IO.IO exposing (..)
import IO.Runner exposing (Request, Response)
import IO.Runner as Run

firstOccurrenceTests = 
  Suite "firstOccurrence"
   [
     test "realistic example" (A.assertEqual (Just 3) (Subject.firstOccurrence '=' "foo=bar"))
   ]

tests : List Test
tests = [ firstOccurrenceTests
        ] 

console = runDisplay <| Suite "All Tests" tests

port requests : Signal Request
port requests = Run.run responses console

port responses : Signal Response