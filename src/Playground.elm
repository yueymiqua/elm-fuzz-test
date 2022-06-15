module Playground exposing
    ( Character
    , Greeting(..)
    , arya
    , doubleScores
    , getAdultAge
    , guardiansWithShortNames
    , highestScores
    , main
    , resultMap5Example
    , sansa
    , sayHello
    , scoresLessThan320
    , signUp
    , welcomeMessage
    )

import Array exposing (empty)
import Html exposing (Html, text)
import Json.Decode exposing (decodeString, int)
import MyList exposing (..)
import Regex


escapeEarth : Float -> Float -> String
escapeEarth myVelocity mySpeed =
    if myVelocity > 11.186 then
        "Godspeed"

    else if mySpeed == 7.67 then
        "Stay in orbit"

    else
        "Come back"


computeSpeed : Float -> Float -> Float
computeSpeed distance time =
    distance / time


computeTime : Float -> Float -> Float
computeTime startTime endTime =
    endTime - startTime


add : Float -> Float -> Float
add a b =
    a + b


multiply : Float -> Float -> Float
multiply c d =
    c * d


divide : Float -> Float -> Float
divide e f =
    e / f


descending : Float -> Float -> Order
descending a b =
    case compare a b of
        LT ->
            GT

        GT ->
            LT

        EQ ->
            EQ


guardians : List String
guardians =
    [ "Star-lord", "Groot", "Gamora", "Drax", "Rocket" ]


guardiansLength : List Int
guardiansLength =
    List.map String.length guardians


filteredGuardiansLength : List String
filteredGuardiansLength =
    List.filter (\x -> String.length x > 5) guardians


multiplyByFive : Int -> Int
multiplyByFive number =
    let
        multiplier =
            5
    in
    number * multiplier


scoreMultiplier : Int
scoreMultiplier =
    2


highestScores : List Int
highestScores =
    [ 316, 320, 312, 370, 337, 318, 314 ]


doubleScores : List Int -> List Int
doubleScores scores =
    List.map (\x -> x * scoreMultiplier) scores


scoresLessThan320 : List Int -> List Int
scoresLessThan320 scores =
    List.filter isLessThan320 scores


isLessThan320 : Int -> Bool
isLessThan320 score =
    score < 320



{- Takes a list of strings and
   returns an integer value
-}


guardiansWithShortNames : List String -> Int
guardiansWithShortNames g =
    g
        |> List.map String.length
        |> List.filter (\x -> x < 6)
        |> List.length


type Greeting
    = Howdy
    | Hola
    | Namaste String
    | NumericalHi Int Int


sayHello : Greeting -> String
sayHello greeting =
    case greeting of
        Howdy ->
            "How y'all doin'?"

        Hola ->
            "Hola amigo!"

        Namaste message ->
            message

        NumericalHi value1 value2 ->
            value1 + value2 |> String.fromInt


welcomeMessage : Bool -> String
welcomeMessage isLoggedIn =
    if isLoggedIn == True then
        "Welcome to my awesome website!"

    else
        "Please log in"


signUp : String -> String -> Result String String
signUp email ageStr =
    case String.toInt ageStr of
        Nothing ->
            Err "Age must be an integer."

        Just age ->
            let
                emailPattern =
                    "\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}\\b"

                regex =
                    Maybe.withDefault Regex.never <|
                        Regex.fromString emailPattern

                isValidEmail =
                    Regex.contains regex email
            in
            if age < 13 then
                Err "You need to be at least 13 years old to sign up."

            else if isValidEmail then
                Ok "Your account has been created successfully!"

            else
                Err "You entered an invalid email."


type alias Character =
    { name : String
    , age : Maybe Int
    }


sansa : Character
sansa =
    { name = "Sansa"
    , age = Just 19
    }


arya : Character
arya =
    { name = "Arya"
    , age = Nothing
    }


getAdultAge : Character -> Maybe Int
getAdultAge character =
    case character.age of
        Nothing ->
            Nothing

        Just age ->
            if age >= 18 then
                Just age

            else
                Nothing


list1 : MyList a
list1 =
    Empty


list2 : MyList number
list2 =
    Node 9 Empty


map5 :
    (a -> b -> c -> d -> e -> value)
    -> Result x a
    -> Result x b
    -> Result x c
    -> Result x d
    -> Result x e
    -> Result x value
map5 func ra rb rc rd re =
    case ra of
        Err x ->
            Err x

        Ok a ->
            case rb of
                Err x ->
                    Err x

                Ok b ->
                    case rc of
                        Err x ->
                            Err x

                        Ok c ->
                            case rd of
                                Err x ->
                                    Err x

                                Ok d ->
                                    case re of
                                        Err x ->
                                            Err x

                                        Ok e ->
                                            Ok (func a b c d e)


resultMap5Example : Result Json.Decode.Error Int
resultMap5Example =
    Result.map5 addFiveNumbers
        (decodeString int "1")
        (decodeString int "2")
        (decodeString int "3")
        (decodeString int "4")
        (decodeString int "5")


addFiveNumbers : Int -> Int -> Int -> Int -> Int -> Int
addFiveNumbers a b c d e =
    a + b + c + d + e


main : Html msg
main =
    isEmpty list2
        |> Debug.toString
        |> text
