# Elm Parameter Parsing

This is an elm library for parsing parameters on the URL.

## To use it

```elm package install jessitron/elm-param-parsing`e this, you'll need
to create an input port, pass the search string to Elm, and then parse
them with this function, then that can populate your model.

For instance, in the web page:

   var app = Elm.fullscreen(Elm.YourModule,
               { locationSearch: window.location.search });

in YourModule.elm:

port locationSearch : String
Then parse the value of the port - this example discards errors:

```parameters : Dict String String
parameters =
  case (parseSearchString locationSearch) of
    Error _ -> Dict.empty
    UrlParams dict -> dict```

Then use that dict when you call your init function that needs the value
of the parameter.

```init (Dict.get parameters "customerID")

init : Maybe String -> Model
init maybeID = ...```

## see it in action

The example app is built into this repo.
[source](http://jessitron.)
[Live](http://jessitron.github.io/elm-param-parsing)

