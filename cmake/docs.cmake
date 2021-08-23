# Turned On by: cmake -DDOCS=On ..
if(DOCS)
    find_package(Doxygen REQUIRED)

    add_custom_target(
        docs
        COMMAND ${DOXYGEN_EXECUTABLE} ${PROJECT_SOURCE_DIR}/docs/Doxyfile
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM
    )
endif()


