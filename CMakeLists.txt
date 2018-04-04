
cmake_minimum_required(VERSION 3.8.2)

project(smela-project CXX)

# Set current project version.
set(VERSION_MAJOR 1)
set(VERSION_MINOR 0)
set(VERSION_PATCH 0)

# Organize targets into folders.
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Extend a list of directories specifying a search path for CMake modules
# to be loaded by the the include() or find_package() commands.
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Load and run CMake code from the file given.
include(ExternalProject)
include(cotire)
include(CxxCompilerOptions)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
# Set global include directories, libraries directories, definitions, etc.
conan_basic_setup()

add_subdirectory(modules/smela)

enable_testing()
add_subdirectory(tests)

if (ENABLE_CLANG_TIDY)
	include(ClangTydi)
endif ()
