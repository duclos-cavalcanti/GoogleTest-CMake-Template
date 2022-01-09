cmake_minimum_required(VERSION 3.4 FATAL_ERROR)

set(PROJECT_TEST_NAME 
    gtest-template-test)

project(${PROJECT_TEST_NAME})

set(CMAKE_MODULE_PATH 
    ${PROJECT_SOURCE_DIR}/cmake)

include(dependencies)
include(gtest-build)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_C_COMPILER ${GCC_PATH})
set(CMAKE_CXX_OUTPUT_EXTENSION_REPLACE ON)

add_definitions(-fprofile-arcs -ftest-coverage)

set(CMAKE_C_FLAGS 
    "${CMAKE_C_FLAGS} -g -O0 -Wall --coverage -fprofile-arcs -ftest-coverage")

set(CMAKE_CXX_FLAGS 
    "${CMAKE_CXX_FLAGS} -std=c++11 -g -O0 -Wall --coverage -fprofile-arcs -ftest-coverage")

set (PARENT_DIR
    ${PROJECT_SOURCE_DIR}/..)

file(GLOB TEST_SOURCES 
     ${PROJECT_SOURCE_DIR}/src/*.cc)

file(GLOB LIB_SOURCES 
    ${PARENT_DIR}/lib/*.c)

file(GLOB SOURCES 
    ${PARENT_DIR}/src/*.c)

list(REMOVE_ITEM 
     SOURCES 
     ${PARENT_DIR}/src/main.c)

set(PROJECT_INCLUDES
    ${PARENT_DIR}/include
    ${PARENT_DIR}/lib/include
    ${PROJECT_SOURCE_DIR}/include
    ${PROJECT_SOURCE_DIR}/mock
    ${PROJECT_SOURCE_DIR}/mock/include
)

set(PROJECT_SOURCES
    ${TEST_SOURCES}
    ${LIB_SOURCES}
    ${SOURCES} 
)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY 
    ${PROJECT_SOURCE_DIR}/bin/)

include_directories(${PROJECT_INCLUDES})

add_executable(${PROJECT_TEST_NAME} 
               ${PROJECT_SOURCES})

target_link_libraries(${PROJECT_TEST_NAME} 
                      gtest
                      gmock_main
                      # gmock
                      )

include(test)
include(coverage)
include(docs)
include(clean)
