add_custom_target(
        cln
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/build/
        COMMENT "Cleaning Build Files"
        COMMAND rm -rf ${PROJECT_SOURCE_DIR}/build/*
        COMMAND [ -d ${PROJECT_SOURCE_DIR}/build/.cache ] && rm -rf ${PROJECT_SOURCE_DIR}/build/*
        COMMAND touch .gitkeep
)
