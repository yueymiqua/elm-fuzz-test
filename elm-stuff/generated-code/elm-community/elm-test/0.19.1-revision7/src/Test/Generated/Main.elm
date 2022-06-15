module Test.Generated.Main exposing (main)

import TestExample

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    Test.Runner.Node.run
        { runs = 100
        , report = ConsoleReport UseColor
        , seed = 294385121824617
        , processes = 10
        , globs =
            [ "tests/TestExample.elm"
            ]
        , paths =
            [ "/Users/pierreyue/Desktop/beginning-elm/tests/TestExample.elm"
            ]
        }
        [ ( "TestExample"
          , [ Test.Runner.Node.check TestExample.addOneTests
            ]
          )
        ]