module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- model


type alias Model =
    { players : List Player
    , name : String
    , playerId : Maybe Int
    , plays : List Play
    }


type alias Player =
    { id : Int
    , name : String
    , points : Int
    }


type alias Play =
    { id : Int
    , playerId : Int
    , name : String
    , points : Int
    }


initModel : Model
initModel =
    { players = []
    , name = ""
    , playerId = Nothing
    , plays = []
    }



-- update


type Msg
    = Edit Player
    | Score Player Int
    | Input String
    | Save
    | Cancel
    | DeletePlay Play


save : Model -> Model
save model =
    case model.playerId of
        Just id ->
            edit model id

        Nothing ->
            add model


add : Model -> Model
add model =
    let
        player =
            Player (List.length model.players) model.name 0

        newPlayers =
            player :: model.players
    in
        { model
            | players = newPlayers
            , name = ""
        }


edit : Model -> Int -> Model
edit model id =
    let
        newPlayers =
            model.players
                |> List.map
                    (\player ->
                        if player.id == id then
                            { player | name = model.name }
                        else
                            player
                    )

        newPlays =
            model.plays
                |> List.map
                    (\play ->
                        if play.playerId == id then
                            { play | name = model.name }
                        else
                            play
                    )
    in
        { model
            | players = newPlayers
            , plays = newPlays
            , name = ""
            , playerId = Nothing
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input name ->
            { model | name = name }

        Save ->
            if (String.isEmpty model.name) then
                model
            else
                save model

        Cancel ->
            { model | name = "", playerId = Nothing }

        _ ->
            model



--view


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1 [] [ text "score Keeper" ]
        , playerSection model
        , playerForm model
        , p [] [ text (toString model) ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
