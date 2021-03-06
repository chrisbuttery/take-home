module Client.Admin.Views (..) where

import Html exposing (..)
import Html.Attributes exposing (for, id, type', name, action, method, enctype, attribute, href)
import Html.Tags exposing (style, stylesheetLink)
import Html.Helpers exposing (class)
import String
import Dict
import Record
import Client.Components exposing (..)
import Client.Styles exposing (..)
import Shared.Test exposing (..)
import Shared.User exposing (..)
import Shared.Routes exposing (..)


loginView =
    form
        [ action routes.login
        , method "POST"
        , enctype "multipart/form-data"
        ]
        [ stylesheetLink assets.main.route
        , passwordLabel "Please enter the admin password"
        , passwordField
        , submitField
        ]


linkToRegisterView : Html
linkToRegisterView =
    a
        [ href routes.registerUser
        , class Button
        ]
        [ text "Click here to register a new user" ]


registerUserView : Html
registerUserView =
    form
        [ action routes.registerUser
        , method "POST"
        , enctype "multipart/form-data"
        ]
        [ emailLabel "Please enter the email for the canidate"
        , emailField
        , submitField
        ]


successfulRegistrationView : String -> User -> Html
successfulRegistrationView url user =
    div
        []
        [ div [] [ text "Please send this url to the candidate" ]
        , a
            [ href url ]
            [ text url ]
        ]


userView : User -> Html
userView user =
    Record.asDict user
        |> Dict.toList
        |> List.map
            (\( field, value ) ->
                li [] [ text (field ++ " : " ++ (toString value)) ]
            )
        |> ul
            [ userClassesBasedOnTime user ]


allUsersView : List User -> Html
allUsersView users =
    div
        []
        [ stylesheetLink assets.main.route
        , stylesheetLink assets.admin.route
        , linkToRegisterView
        , List.map (\user -> li [] [ userView user ]) users
            |> ul []
        ]
