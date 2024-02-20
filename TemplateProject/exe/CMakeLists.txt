set(EXECUTABLE_NAME "example")
set(SOURCE_FILES source/logger.cpp source/main.cpp)

add_executable(${EXECUTABLE_NAME} ${SOURCE_FILES})
target_include_directories(${EXECUTABLE_NAME} PRIVATE source include)
target_link_libraries(${EXECUTABLE_NAME} examplelib)
