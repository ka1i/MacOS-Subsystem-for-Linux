cmake_minimum_required(VERSION 3.16)

project(linux_virtual_machine LANGUAGES Swift)

set(CMAKE_BUILD_TYPE "Release") 
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_SOURCE_DIR}/swift)

include(options.cmake)

add_subdirectory(swift-argument-parser)
add_subdirectory(VirtualizationKit)

add_executable(${PROJECT_NAME}
  src/app.swift
  src/main.swift
  src/version.swift)

target_link_libraries(${PROJECT_NAME} PRIVATE VirtualizationKit)

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework Foundation Virtualization")
