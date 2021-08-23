add_custom_target("report"
    COMMAND echo "=================== Testing/Report ===================="
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    COMMAND python test.py
)

add_dependencies(report 
                ${PROJECT_TEST_NAME})
