cmake_minimum_required(VERSION 3.16)

project(VirtualizationKit LANGUAGES Swift)

set(CMAKE_BUILD_TYPE "Release") 
set(LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib)

add_library(${PROJECT_NAME} SHARED
virtualkit.swift)

set_target_properties(${PROJECT_NAME} PROPERTIES
 VERSION 1.0.1
 SOVERSION 1)

target_link_libraries(${PROJECT_NAME} )
