#include "hello-inc.h"

int exampleDecrement(int val)
{
        return --val;
}

int exampleDecrementDummy1(int val)
{
        int val_dummy = val;            // Dummy Lines 
        return --val;
}

int exampleDecrementDummy2(int val)
{
        int val_dummy_1 = val;            // Dummy Lines 
        int val_dummy_2 = val + 1;        // Dummy Lines 
        val_dummy_1++;                    // Dummy Lines 
        return --val;
}
