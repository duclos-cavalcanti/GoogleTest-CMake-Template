#include <gtest/gtest.h>

extern "C"
{
#include "hello-lib.h"
#include "hello-inc.h"
}

// Simple test case
TEST(HelloTestSuiteTest, HelloTestName_Increment_1) {
  // This test is named HelloTestName 
  // But belongst the Hello Test

  EXPECT_EQ(2, exampleIncrement(1));

  // EXPECT_EQ(expected, actual) is the same as
  //
  //   EXPECT_TRUE((expected) == (actual))
  //
  // except that it will print both the expected value and the actual
  // value when the assertion fails.  This is very helpful for
  // debugging.  Therefore in this case EXPECT_EQ is preferred.
  //
  // On the other hand, EXPECT_TRUE accepts any Boolean expression,
  // and is thus more general.
}

TEST(HelloTestSuiteTest, HelloTestName_Decrement_1) {
  EXPECT_EQ(1, exampleDecrement(2));
}

TEST(HelloTestSuiteTest, HelloTestName_Decrement_2) {
  EXPECT_EQ(1, exampleDecrement(1));
}
