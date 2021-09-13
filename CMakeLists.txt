cmake_minimum_required(VERSION 3.16)

project(lxv LANGUAGES Swift)

set(CMAKE_BUILD_TYPE "Release") 
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin)

add_subdirectory(VirtualizationKit)

add_executable(${PROJECT_NAME} src/hello.swift)
target_link_libraries(${PROJECT_NAME} PRIVATE HiKit)
