
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

<<<<<<< HEAD
=======
if (MSVC14 OR MSVC15)
	add_definitions(-D_SCL_SECURE_NO_WARNINGS)
	add_compile_options(/EHsc /W4 /WX)

	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
else ()
	include(CheckCXXCompilerFlag)
	CHECK_CXX_COMPILER_FLAG("-std=c++14" COMPILER_SUPPORTS_CXX14)
	CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
	if (COMPILER_SUPPORTS_CXX14)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")
	elseif (COMPILER_SUPPORTS_CXX11)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
	else ()
		message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. "
			"Please use a different C++ compiler.")
	endif ()
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} \
		-fno-strict-aliasing -Wall -Wcast-align -Wconversion -Wctor-dtor-privacy \
		-Werror -Wunused-command-line-argument -Wextra -Wno-missing-braces \
		-Wnon-virtual-dtor -Wold-style-cast -Woverloaded-virtual -Wpedantic \
		-Wshadow -Wsign-conversion")
#	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
	
	if (ENABLE_COVERAGE)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 -fprofile-arcs -ftest-coverage")
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --coverage")
	endif ()
endif ()

>>>>>>> parent of a89e3ad... Fixed root CMakeLists.txt file.
add_subdirectory(modules/smela)

enable_testing()
add_subdirectory(tests)
