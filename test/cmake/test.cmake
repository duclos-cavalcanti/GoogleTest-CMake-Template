add_custom_target("report"
    COMMENT "TESTING/REPORT"
    DEPENDS ${PROJECT_TEST_NAME} base
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    COMMAND python3 test.py
)
