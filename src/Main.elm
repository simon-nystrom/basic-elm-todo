module Main exposing (..)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


init : Model
init =
    { value = "", todos = [] }


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Todo =
    { id : Int, task : String, isComplete : Bool }


type alias Model =
    { value : String, todos : List Todo }


type Msg
    = UpdateInput String
    | AddTodo


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateInput input ->
            { model | value = input }

        AddTodo ->
            case model.value of
                "" ->
                    model

                _ ->
                    { model
                        | todos =
                            { id = List.length model.todos
                            , task = model.value
                            , isComplete = False
                            }
                                :: model.todos
                    }


viewTodo : Todo -> Html Msg
viewTodo t =
    div [] [ text t.task ]


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput UpdateInput ] []
        , button [ onClick AddTodo ] [ text "Add" ]
        , div [] (List.map viewTodo model.todos)
        ]
