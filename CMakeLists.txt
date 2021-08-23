cmake_minimum_required(VERSION 3.4 FATAL_ERROR)

set(PROJECT_NAME 
    gtest-template)

set(PROJECT_TEST_NAME 
    gtest-template-test)

project(${PROJECT_NAME})

set(CMAKE_MODULE_PATH 
    ${PROJECT_SOURCE_DIR}/cmake)


set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

file(GLOB SOURCES 
     "src/*.c")
file(GLOB LIB_SOURCES 
     "lib/*.c")


SET(PROJECT_SOURCES
    ${SOURCES} 
    ${LIB_SOURCES}
)

SET(PROJECT_INCLUDES
    ${PROJECT_SOURCE_DIR}/include/
    ${PROJECT_SOURCE_DIR}/lib/include
)

set(CMAKE_MODULE_PATH 
    ${PROJECT_SOURCE_DIR}/cmake)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY 
    ${PROJECT_SOURCE_DIR}/bin)

include_directories(${PROJECT_INCLUDES})

add_executable(${PROJECT_NAME} 
               ${PROJECT_SOURCES})
include(docs)
