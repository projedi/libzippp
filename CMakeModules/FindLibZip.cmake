# Will use LIBZIP_ROOT as a hint.
# Will define as a result:
# LIBZIP_INCLUDE_DIRS
# LIBZIP_LIBRARIES
# LIBZIP_FOUND

set(_LIBZIP_SEARCH_PATHS)
if(LIBZIP_ROOT)
   list(APPEND _LIBZIP_SEARCH_PATHS ${LIBZIP_ROOT})
endif()

find_path(_LIBZIP_INCLUDE_DIR NAMES zip.h PATHS ${_LIBZIP_SEARCH_PATHS}
   PATH_SUFFIXES include)

find_library(_LIBZIP_LIBRARY NAMES zip PATHS ${_LIBZIP_SEARCH_PATHS}
   PATH_SUFFIXES lib)

set(LIBZIP_INCLUDE_DIRS)
set(LIBZIP_LIBRARIES)

if(_LIBZIP_LIBRARY AND _LIBZIP_INCLUDE_DIR)
   set(LIBZIP_INCLUDE_DIRS ${_LIBZIP_INCLUDE_DIR})
   set(LIBZIP_LIBRARIES ${_LIBZIP_LIBRARY})
endif()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(LibZip DEFAULT_MSG _LIBZIP_INCLUDE_DIR _LIBZIP_LIBRARY)
