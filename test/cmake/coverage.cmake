##############################
## Setting Global Variables ##
##############################
set (COVERAGE_DIRECTORIES
    src
    )

set (COVERAGE_TEST_DIRECTORIES
    src
    # mock
    )

set (GLOBAL_COVERAGE_VARIABLES "")

foreach(var ${COVERAGE_DIRECTORIES})
    set (GLOBAL_COVERAGE_VARIABLES ${GLOBAL_COVERAGE_VARIABLES} ${var})
endforeach()

foreach(var ${COVERAGE_TEST_DIRECTORIES})
    set (GLOBAL_COVERAGE_VARIABLES ${GLOBAL_COVERAGE_VARIABLES} test-${var})
endforeach()

set(CREATE_DIRS 
    ${PROJECT_SOURCE_DIR}/reports/coverage/info
    ${PROJECT_SOURCE_DIR}/reports/coverage/test
    ${PROJECT_SOURCE_DIR}/reports/coverage/total
    )
foreach(var ${GLOBAL_COVERAGE_VARIABLES})
    string(TOUPPER ${var} upper_var)

    set (${upper_var}_INFO
         ${PROJECT_SOURCE_DIR}/reports/coverage/info/${PROJECT_TEST_NAME}_${var}.info
        )

    set (${upper_var}_BASE_INFO
         ${PROJECT_SOURCE_DIR}/reports/coverage/info/${PROJECT_TEST_NAME}_${var}_base.info
        )

    set (${upper_var}_TOTAL_INFO
         ${PROJECT_SOURCE_DIR}/reports/coverage/info/${PROJECT_TEST_NAME}_${var}_total.info
        )

    set (CREATE_DIRS
         ${CREATE_DIRS}
         ${PROJECT_SOURCE_DIR}/reports/coverage/${var}
        )
endforeach()

####################################
## Creating Necessary Directories ##
####################################
foreach(direc ${CREATE_DIRS})
    if(NOT EXISTS "${direc}")
        make_directory("${direc}")
        message("--> Creating Directory ${direc}")
    endif()
endforeach()

#############
## TARGETS ##
#############
set (MAIN_TARGETS "")
set (BASE_TARGETS "")
set (TEST_MERGE_INFOS "")
set (MERGE_INFOS "")
foreach(var ${COVERAGE_DIRECTORIES})
    string(FIND ${var} "+" var_bool)

    if(${var_bool} EQUAL -1)
        set (var_path ${var})
    else()
        string(REPLACE "+" "/" tmp ${var})
        set (var_path ${tmp})
    endif()

    set (WORK_DIR
         ${CMAKE_BINARY_DIR}/CMakeFiles/${PROJECT_TEST_NAME}.dir/${PARENT_DIR}/${var_path}
        )
    string(TOUPPER ${var} upper_var)
    add_custom_target(coverage-${var}-base
        COMMENT "BASE COVERAGE -> ${var}"
        WORKING_DIRECTORY ${WORK_DIR}
        COMMAND lcov -z -d . -o ${${upper_var}_BASE_INFO}
        COMMAND lcov -c -i -d . -o ${${upper_var}_BASE_INFO}
    )

    add_custom_target(coverage-${var}
        COMMENT "COVERAGE -> ${var}"
        WORKING_DIRECTORY ${WORK_DIR}
        COMMAND lcov -c -d . -o ${${upper_var}_INFO}
        COMMAND lcov -a ${${upper_var}_INFO} -a ${${upper_var}_BASE_INFO} -o ${${upper_var}_TOTAL_INFO}
        COMMAND genhtml ${${upper_var}_TOTAL_INFO}  -o ${PROJECT_SOURCE_DIR}/reports/coverage/${var}/
        )

    add_dependencies(coverage-${var} report) 

    set (MERGE_INFOS
        ${MERGE_INFOS}
        ${${upper_var}_TOTAL_INFO}
        )

    set (BASE_TARGETS
        ${BASE_TARGETS}
        coverage-${var}-base
        )

    set (MAIN_TARGETS
        ${MAIN_TARGETS}
        coverage-${var}
        )
endforeach()

foreach(var ${COVERAGE_TEST_DIRECTORIES})
    string(FIND ${var} "+" var_bool)

    if(${var_bool} EQUAL -1)
        set (var_path ${var})
    else()
        string(REPLACE "+" "/" tmp ${var})
        set (var_path ${tmp})
    endif()
    set (WORK_DIR
         ${CMAKE_BINARY_DIR}/CMakeFiles/${PROJECT_TEST_NAME}.dir/${var_path}
        )

    set (var test-${var})
    string(TOUPPER ${var} upper_var)
    add_custom_target(coverage-${var}-base
        COMMENT "BASE COVERAGE -> ${var}"
        WORKING_DIRECTORY ${WORK_DIR}
        COMMAND lcov -z -d . -o ${${upper_var}_BASE_INFO}
        COMMAND lcov -c -i -d . -o ${${upper_var}_BASE_INFO}
        )
    add_custom_target(coverage-${var}
        COMMENT "COVERAGE -> ${var}"
        WORKING_DIRECTORY ${WORK_DIR}
        COMMAND lcov -c -d . -o ${${upper_var}_INFO}
        COMMAND lcov -a ${${upper_var}_INFO} -a ${${upper_var}_BASE_INFO} -o ${${upper_var}_TOTAL_INFO}
        COMMAND genhtml ${${upper_var}_TOTAL_INFO}  -o ${PROJECT_SOURCE_DIR}/reports/coverage/${var}/
        )

    add_dependencies(coverage-${var} report) 

    set (TEST_MERGE_INFOS
        ${TEST_MERGE_INFOS}
        ${${upper_var}_TOTAL_INFO}
        )

    set (BASE_TARGETS
        ${BASE_TARGETS}
        coverage-${var}-base
        )

    set (TEST_TARGETS
        ${TEST_TARGETS}
        coverage-${var}
        )
endforeach()

set (MERGE_COMMAND bash -c "lcov ")
foreach(var ${COVERAGE_DIRECTORIES})
    string(TOUPPER ${var} upper_var)
    string(APPEND MERGE_COMMAND "-a ${PROJECT_TEST_NAME}_${var}_total.info ")
endforeach()
string(APPEND MERGE_COMMAND "-o ${PROJECT_TEST_NAME}_merged.info")

set (MERGE_TEST_COMMAND bash -c "lcov ")
foreach(var ${COVERAGE_TEST_DIRECTORIES})
    string(TOUPPER ${var} upper_var)
    string(APPEND MERGE_TEST_COMMAND "-a ${PROJECT_TEST_NAME}_test-${var}_total.info ")
endforeach()
string(APPEND MERGE_TEST_COMMAND "-o ${PROJECT_TEST_NAME}_test_merged.info")

add_custom_target(coverage-merge-test
    COMMENT "COVERAGE MERGE TEST"
    DEPENDS ${TEST_TARGETS}
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/reports/coverage/info/
    COMMAND ${MERGE_TEST_COMMAND}
    COMMAND lcov --remove ${PROJECT_TEST_NAME}_test_merged.info  '/usr/include/*' -o ${PROJECT_TEST_NAME}_test_merged.info
    COMMAND lcov --remove ${PROJECT_TEST_NAME}_test_merged.info  '*gtest/*' -o ${PROJECT_TEST_NAME}_test_merged.info
    COMMAND genhtml ${PROJECT_TEST_NAME}_test_merged.info  -o ${PROJECT_SOURCE_DIR}/reports/coverage/test
    )

add_custom_target(coverage-merge
    COMMENT "COVERAGE MERGE"
    DEPENDS ${MAIN_TARGETS}
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/reports/coverage/info/
    COMMAND ${MERGE_COMMAND}
    COMMAND lcov --remove ${PROJECT_TEST_NAME}_merged.info  '/usr/include/*' -o ${PROJECT_TEST_NAME}_merged.info
    COMMAND lcov --remove ${PROJECT_TEST_NAME}_merged.info  '*gtest/*' -o ${PROJECT_TEST_NAME}_merged.info
    COMMAND genhtml ${PROJECT_TEST_NAME}_merged.info  -o ${PROJECT_SOURCE_DIR}/reports/coverage/total
)

add_custom_target(base 
                  COMMENT "COVERAGE BASE DONE"
                  DEPENDS ${BASE_TARGETS})

add_custom_target(coverage 
                  COMMENT "COVERAGE DONE"
                  DEPENDS ${MAIN_TARGETS} ${TEST_TARGETS} coverage-merge coverage-merge-test)

