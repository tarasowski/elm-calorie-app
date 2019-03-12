module Main exposing (Model)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { calories : Int
    , input : Int
    , error : Maybe String
    }



{-
   -- Is the same as below Model 0 0 Nothing
      initModel =
        { calories = 0
        , input = 0
        , error = Nothing
        }

-}


initModel : Model
initModel =
    Model 0 0 Nothing


type Msg
    = AddCalorie
    | Clear
    | Input String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            { model
                | calories = model.calories + model.input
                , input = 0
            }

        Clear ->
            initModel

        Input val ->
            case String.toInt val of
                Ok input ->
                    { model
                        | input = input
                        , error = Nothing
                    }

                Err err ->
                    { model
                        | input = 0
                        , error = Just err
                    }



-- Html Msg means it's Html that can generate messages AddCalorie or Clear


view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text ("Total Calories: " ++ toString model.calories) ]
        , input
            [ type_ "text"
            , name "calorieInput"
            , onInput Input
            , value
                (if model.input == 0 then
                    ""

                 else
                    toString model.input
                )
            ]
            []
        , div [] [ text (Maybe.withDefault "" model.error) ]
        , button
            [ type_ "button"
            , onClick AddCalorie
            ]
            [ text "Add" ]
        , button
            [ type_ "button"
            , onClick Clear
            ]
            [ text "Clear" ]
        ]


main =
    Html.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }
