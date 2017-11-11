project(smela-project)

cmake_minimum_required(VERSION 3.0.0)

set(VERSION_MAJOR 1)
set(VERSION_MINOR 0)
set(VERSION_PATCH 0)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(cotire)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

if (MSVC14)
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
		-fno-strict-aliasing -Wall -Wcast-align -Wconversion -Wctor-dtor-privacy -Werror \
		-Wextra -Wno-missing-braces -Wnon-virtual-dtor -Wold-style-cast -Woverloaded-virtual \
		-Wpedantic -Wshadow -Wsign-conversion")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
endif ()

add_subdirectory(modules/smela)
