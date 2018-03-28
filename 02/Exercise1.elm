module Main exposing (..)

import Html


(~) a b =
    let
        a0 =
            String.left 1 a

        b0 =
            String.left 1 b
    in
        if a0 == b0 then
            True
        else
            False


main =
    toString ("Danny" ~ "Danny") |> Html.text
