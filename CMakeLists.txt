cmake_minimum_required(VERSION 3.16)

project(linux_virtual_machine LANGUAGES Swift)

set(CMAKE_BUILD_TYPE "Release") 
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin)

add_subdirectory(VirtualizationKit)

add_executable(${PROJECT_NAME} src/main.swift)
target_link_libraries(${PROJECT_NAME} PRIVATE VirtualizationKit)

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework Foundation Virtualization")
