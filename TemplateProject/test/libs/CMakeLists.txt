# List tests in here and add main.cpp for each

set(TEST_NAME examplelib_tests)
set(TEST_SOURCES examplelib/examplelib_test.cpp)
set(LINKED_LIBS gtest_main examplelib)

add_executable(${TEST_NAME} ${TEST_SOURCES})

target_link_libraries(${TEST_NAME} ${LINKED_LIBS})

gtest_discover_tests(${TEST_NAME})
