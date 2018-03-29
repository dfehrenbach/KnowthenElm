module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- model


type alias Model =
    { calories : Int
    , calorieText : String
    }


initModel : Model
initModel =
    { calories = 0
    , calorieText = ""
    }



-- update


type Msg
    = AddCalories Int
    | ChangeCalories String
    | Clear


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalories newCalories ->
            { model
                | calories = newCalories
                , calorieText = ""
            }

        ChangeCalories newText ->
            { model | calorieText = newText }

        Clear ->
            initModel



-- view


view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text ("Total Calories: " ++ (toString model.calories))
            ]
        , input
            [ value model.calorieText
            , onInput ChangeCalories
            ]
            []
        , button
            [ type_ "button"
            , onClick
                (AddCalories
                    (model.calorieText
                        |> String.toInt
                        |> Result.toMaybe
                        |> Maybe.withDefault 0
                        |> (+) model.calories
                    )
                )
            ]
            [ text "Add" ]
        , button
            [ type_ "button"
            , onClick Clear
            ]
            [ text "Clear" ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }
