set(LIB_NAME "examplelib")
set(SOURCE_FILES source/examplelib.cpp)

add_library(${LIB_NAME} ${SOURCE_FILES})

target_include_directories(
  ${LIB_NAME}
  PRIVATE source
  PUBLIC include)
