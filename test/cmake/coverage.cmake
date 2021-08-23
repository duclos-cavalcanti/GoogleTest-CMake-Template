if(NOT EXISTS "${PROJECT_SOURCE_DIR}/reports/coverage/info")
    make_directory("${PROJECT_SOURCE_DIR}/reports/coverage/info")
endif()

if(NOT EXISTS "${PROJECT_SOURCE_DIR}/reports/coverage/total")
    make_directory("${PROJECT_SOURCE_DIR}/reports/coverage/total")
endif()

add_custom_target(gcov
    COMMAND mkdir -p coverage
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )

add_custom_command(TARGET gcov
    COMMENT "=================== Coverage - GCOV ===================="
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/CMakeFiles/${PROJECT_TEST_NAME}.dir/src
    COMMAND gcov -b *.gcno
    # COMMAND mv *.gcov ${CMAKE_BINARY_DIR}/coverage
    )

add_dependencies(gcov 
                 ${PROJECT_TEST_NAME}) 

if(NOT EXISTS "${PROJECT_SOURCE_DIR}/reports/coverage/test")
    make_directory("${PROJECT_SOURCE_DIR}/reports/coverage/test")
endif()
add_custom_target(coverage-test
    COMMENT "=================== Coverage - LCOV - tests ===================="
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/CMakeFiles/${PROJECT_TEST_NAME}.dir/src
    COMMAND lcov -c -d . -o ${PROJECT_TEST_NAME}_test.info
    COMMAND lcov --remove ${PROJECT_TEST_NAME}_test.info '/usr/include/*' -o ${PROJECT_TEST_NAME}_test.info
    COMMAND lcov --remove ${PROJECT_TEST_NAME}_test.info '*gtest/*' -o ${PROJECT_TEST_NAME}_test.info
    COMMAND genhtml ${PROJECT_TEST_NAME}_test.info --output-directory ${PROJECT_SOURCE_DIR}/reports/coverage/test
    )

add_dependencies(coverage-test
                 report
                ) 

if(NOT EXISTS "${PROJECT_SOURCE_DIR}/reports/coverage/lib")
    make_directory("${PROJECT_SOURCE_DIR}/reports/coverage/lib")
endif()
add_custom_target(coverage-lib
    COMMENT "=================== Coverage - LCOV - lib ===================="
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/CMakeFiles/${PROJECT_TEST_NAME}.dir/${PARENT_DIR}/lib
    COMMAND lcov -c -d . -o ${PROJECT_SOURCE_DIR}/reports/coverage/info/${PROJECT_TEST_NAME}_lib.info 
    COMMAND genhtml ${PROJECT_SOURCE_DIR}/reports/coverage/info/${PROJECT_TEST_NAME}_lib.info  --output-directory ${PROJECT_SOURCE_DIR}/reports/coverage/lib
    )

add_dependencies(coverage-lib
                 report
                ) 

if(NOT EXISTS "${PROJECT_SOURCE_DIR}/reports/coverage/src")
    make_directory("${PROJECT_SOURCE_DIR}/reports/coverage/src")
endif()
add_custom_target(coverage-src
    COMMENT "=================== Coverage - LCOV - Src ===================="
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/CMakeFiles/${PROJECT_TEST_NAME}.dir/${PARENT_DIR}/src
    COMMAND lcov -c -d . -o ${PROJECT_SOURCE_DIR}/reports/coverage/info/${PROJECT_TEST_NAME}_src.info 
    COMMAND genhtml ${PROJECT_SOURCE_DIR}/reports/coverage/info/${PROJECT_TEST_NAME}_src.info   --output-directory ${PROJECT_SOURCE_DIR}/reports/coverage/src
    )

add_dependencies(coverage-src
                 report
                ) 

add_custom_target(coverage-merge
    COMMENT "=================== Coverage - LCOV - Merge ===================="
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/reports/coverage/info/
    COMMAND lcov -a ${PROJECT_TEST_NAME}_src.info -a ${PROJECT_TEST_NAME}_lib.info -o ${PROJECT_TEST_NAME}_merged.info
    COMMAND genhtml ${PROJECT_TEST_NAME}_merged.info  --output-directory ${PROJECT_SOURCE_DIR}/reports/coverage/total
    )

add_dependencies(coverage-merge
                 coverage-src
                 coverage-lib
                ) 

add_custom_target(coverage
                COMMENT "=================== Coverage Done ===================="
    )

add_dependencies(coverage
                 coverage-src
                 coverage-lib
                 coverage-test
                 coverage-merge
                ) 
