cmake_minimum_required(VERSION 3.18)

project(
  TemplateProject
  VERSION 0.1
  LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(BUILD_TESTING "Enable tests." OFF)

message("Build type: ${CMAKE_BUILD_TYPE}")

add_subdirectory(exe)
add_subdirectory(libs)

if(BUILD_TESTING)
  message("Building with tests!")
  include(CTest)
  add_subdirectory(test)
endif()
