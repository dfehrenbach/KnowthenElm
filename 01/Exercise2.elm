module Main exposing (..)

import Html


capitalize len name =
    if String.length name > len then
        String.toUpper name
    else
        name


capitalize_if_great_than_10 name =
    capitalize 10 name


format name =
    name
        ++ " - name length: "
        ++ (toString (String.length name))


main =
    let
        name =
            "Danny Fehrenbach"
    in
        (format name)
            |> Html.text
