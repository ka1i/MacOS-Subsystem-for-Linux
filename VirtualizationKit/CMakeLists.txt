cmake_minimum_required(VERSION 3.16)

project(HiKit LANGUAGES Swift)

if(CMAKE_SYSTEM_NAME STREQUAL Windows OR CMAKE_SYSTEM_NAME STREQUAL Darwin)
  option(BUILD_SHARED_LIBS "Build shared libraries by default" YES)
endif()

set(CMAKE_BUILD_TYPE "Release") 
set(LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib)

add_library(${PROJECT_NAME} hikit.swift)
target_link_libraries(${PROJECT_NAME} INTERFACE)
