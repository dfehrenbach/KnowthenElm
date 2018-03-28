module Main exposing (..)

import Html


wordCount =
    String.words >> List.length


main =
    wordCount "I might think that elm is a very pretty language"
        |> toString
        |> Html.text
