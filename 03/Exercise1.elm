module Main exposing (..)

import Html exposing (..)


type alias Item =
    { name : String
    , qty : Int
    , freeQty : Int
    }


cart : List Item
cart =
    [ { name = "Lemon", qty = 1, freeQty = 0 }
    , { name = "Apple", qty = 5, freeQty = 0 }
    , { name = "Pear", qty = 10, freeQty = 0 }
    ]


create_special : Int -> Int -> Item -> Item
create_special limit free item =
    if item.qty >= limit then
        { item | freeQty = free }
    else
        item


main : Html msg
main =
    cart
        |> List.map ((create_special 5 1) >> (create_special 10 3))
        |> toString
        |> Html.text
