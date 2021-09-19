cmake_minimum_required(VERSION 3.16)

project(VirtualizationKit LANGUAGES Swift)

set(CMAKE_BUILD_TYPE "Release") 
set(LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib)
set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_SOURCE_DIR}/swift)

add_library(${PROJECT_NAME} STATIC
BootLoader.swift
Configure.swift
Delegate.swift
TerminalSerial.swift
StorageDevice.swift
NetworkDevice.swift
VirtualKit.swift)

set_target_properties(${PROJECT_NAME} PROPERTIES
 VERSION 1.0.1
 SOVERSION 1)

target_link_libraries(${PROJECT_NAME} PUBLIC ArgumentParser)
