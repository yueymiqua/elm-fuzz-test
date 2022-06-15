module TestExample exposing (addOneTests)

-- multiplyFloatTests, stringTests
-- import Expect exposing (FloatingPointTolerance(..))

import Expect
import Fuzz exposing (..)
import Test exposing (..)



-- Fuzz testing allows us to run the code under test over and over again with randomly generated inputs, whereas unit test runs the test code only once


addOneTests : Test
addOneTests =
    describe "addOne"
        {--** By default when fuzz testing random integers, the default range will be -50 to 50 (101 integer values including 0)
        Something to note is that since 0 is notorious for introducing edge cases in most code,
        the int fuzzer will make sure that 0 is one of the generated values in the test.--}
        [ fuzz int "adds 1 to any integer" <|
            \num ->
                addOne num |> Expect.equal (num + 1)

        -- , test "when 1 is added to 2, the result is 3" <|
        --     \_ ->
        --         addOne 2 |> Expect.equal 4
        {--** Only difference between a fuzz test and a unit test output is unit test we know exactly which value it failed at just by looking at the test
        Fuzz test we cannot tell just by looking at the implementation. The int fuzzer generates a value between -50 and 50 and feeds that into the test.
        There is no way of knowing what that value is. --}
        ]



{--** When this test fails, note that the indicated value is "1" that this test suggested to have failed at.
Why did the test output report that the test function logic failed at "1"? Because instead of showing us the value it failed on, it tries to shrink
the failing input to the smallest and simplest value possible. That way it is much easier for us to investigate as to why the test had failed. --}
--
--
--
-- addOneTests : Test
-- addOneTests =
--     describe "addOne"
--         [ fuzzWith { runs = 200 } int "adds 1 to the given integer" <|
--             \num ->
--                 addOne num |> Expect.equal (num + 1)
--         ]
-- addOneTests : Test
-- addOneTests =
--     describe "addOne"
--         [ fuzz (intRange -100 100) "adds 1 to the given integer" <|
--             \num ->
--                 addOne num |> Expect.equal (num + 1)
--         ]


addOne : Int -> Int
addOne x =
    1 + x



{--** Key differences to note when comparing a regular test with a fuzz test
1. fuzz test is created using a function called fuzz whereas unit test is created using test (both using the Test module)
2. fuzz test takes an extra argument compared to unit test which is for generating the random value
This could be a type float, string, list, or maybe value
3. fuzz test then uses the randomly-generated value in the test function as a real parameter instead of an underscore(not used) in a unit test --}
--
--
--
--
--
-- multiplyFloat : Float -> Int -> Float
-- multiplyFloat x y =
--     x * toFloat y
--
--
-- multiplyFloatTests : Test
-- multiplyFloatTests =
--     describe "multiplyFloat"
--         [ fuzz2 float int "multiplies given numbers" <|
--             \x y ->
--                 multiplyFloat x y
--                     |> Expect.equal (x * toFloat y)
--                     -- |> Expect.within (Absolute 0.000000001) (x * toFloat y)
--         ]
--
--
-- stringTests : Test
-- stringTests =
--     describe "The String module"
--         [ describe "String.reverse"
--             [ test "has no effect on a palindrome" <|
--                 -- Unit Test - 1
--                 \_ ->
--                     let
--                         palindrome =
--                             "hannah"
--                     in
--                     palindrome
--                         |> String.reverse
--                         |> Expect.equal palindrome
--             , test "reverses a known string" <|
--                 -- Unit Test - 2
--                 \_ ->
--                     "ABCDEFG"
--                         |> String.reverse
--                         |> Expect.equal "GFEDCBA"
--             , fuzz string "restores the original string if you run it again" <|
--                 -- Fuzz Test
--                 \randomlyGeneratedString ->
--                     randomlyGeneratedString
--                         |> String.reverse
--                         |> String.reverse
--                         |> Expect.equal randomlyGeneratedString
--             ]
--         ]
