find_program(GCC_PATH gcc)
find_program(GCOV_PATH gcov)
find_program(LCOV_PATH lcov)
find_program(GENHTML_PATH genhtml)

if(NOT GCC_PATH)
    message(FATAL_ERROR "GCC NOT FOUND")
endif()

if(NOT GCOV_PATH)
    message(FATAL_ERROR "GCOV NOT FOUND")
endif()

if(NOT LCOV_PATH)
    message(FATAL_ERROR "LCOV NOT FOUND")
endif()

if(NOT GENHTML_PATH)
    message(FATAL_ERROR "GENHTML NOT FOUND")
endif()

