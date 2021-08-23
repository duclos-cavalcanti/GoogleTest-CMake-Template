#include <gtest/gtest.h>
#include <tuple>

extern "C"
{
#include "hello-lib.h"
#include "hello-inc.h"
}

// class HelloTestSuite: public testing::TestWithParam<int> {
class HelloTestSuite: public testing::TestWithParam<std::tuple<int, int>> {
  public:
    int example_method() {
      return method_value_;
    } 

  private:
    int method_value_;
};

TEST_P(HelloTestSuite, HelloTestSuite) {
  int param = std::get<0>(GetParam());
  int res = ++param;
  EXPECT_EQ(res, exampleDecrement(param));
}

INSTANTIATE_TEST_SUITE_P(
    HelloTestInstantiationName, HelloTestSuite, testing::Values(
      std::make_tuple(1, 2), 
      std::make_tuple(2, 3), 
      std::make_tuple(3, 4)
    )
);
