CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH};${CMAKE_CURRENT_SOURCE_DIR}/CMakeModules)

PROJECT(libzippp)

SET(PACKAGE "libzippp")
SET(VERSION "0.1")

SET(LIBZIP_ROOT "lib/libzip-0.11.2" CACHE STRING "Path to libzip")
option(USE_ENTRY_CACHING "Store zip index in memory for faster access.")
option(USE_MALLOC "Use malloc instead of new when allocating arrays of plain data.")
option(BUILD_TESTS "Build tests" ON)

find_package(LibZip REQUIRED)
include_directories(${LIBZIP_INCLUDE_DIRS})

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/src/config.h.in
   ${CMAKE_CURRENT_BINARY_DIR}/libzippp-config.h)

INCLUDE_DIRECTORIES("src")
include_directories(${LIBZIP_ROOT}/include)

add_definitions(-DLIBZIPPP_EXPORTS)
ADD_LIBRARY(libzippp_shared SHARED "src/libzippp.cpp")
SET_TARGET_PROPERTIES(libzippp_shared PROPERTIES OUTPUT_NAME zippp)
target_link_libraries(libzippp_shared ${LIBZIP_LIBRARIES})

add_definitions(-DLIBZIPPP_EXPORTS)
ADD_LIBRARY(libzippp_static STATIC "src/libzippp.cpp")
SET_TARGET_PROPERTIES(libzippp_static PROPERTIES OUTPUT_NAME zippp_static)
target_link_libraries(libzippp_static ${LIBZIP_LIBRARIES})

install(TARGETS libzippp_shared
   RUNTIME DESTINATION "bin"
   LIBRARY DESTINATION "lib")

install(TARGETS libzippp_static
   ARCHIVE DESTINATION "lib")

install(FILES "src/libzippp.h" "${CMAKE_CURRENT_BINARY_DIR}/libzippp-config.h"
   DESTINATION "include")

if(BUILD_TESTS)
   ADD_EXECUTABLE(libzippp_test "tests/tests.cpp")
   TARGET_LINK_LIBRARIES(libzippp_test libzippp_shared)
endif()
