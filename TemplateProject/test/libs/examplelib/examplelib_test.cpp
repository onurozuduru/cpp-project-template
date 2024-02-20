#include <examplelib.h>
#include <gtest/gtest.h>

namespace {

// Tests ExampleLib::addSecretNumber
TEST(ExampleLibTest, AddSecretNumber)
{
    int testArgument = 2;
    int expectedResult = testArgument + 3;

    auto example = ExampleLib {};

    EXPECT_EQ(expectedResult, example.addSecretNumber(testArgument));
}

// Tests ExampleLib::addSecretNumber negative argument
TEST(ExampleLibTest, AddSecretNumberNegativeArgument)
{
    int testArgument = -1;
    int expectedResult = testArgument + 3;

    auto example = ExampleLib {};

    EXPECT_EQ(expectedResult, example.addSecretNumber(testArgument));
}

}
