
# CxxCompilerOptions
# --------------------
#
# Check CXX compiler and set compiler/linker options/flags.
#

if (MSVC14 OR MSVC15)
	add_definitions(
		# Disable warnings using potentially unsafe methods from the Standard C++ Library.
		-D_SCL_SECURE_NO_WARNINGS
	)
	add_compile_options(
		# Catch C++ exceptions only and tells the compiler to assume that
		# functions declared as extern "C" never throw a C++ exception.
		/EHsc
		# Display level 1, level 2, and level 3 warnings, and all
		# level 4 (informational) warnings that are not turned off by default.
		/W4
		# Treat all compiler warnings as errors.
		/WX
	)

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
		message(FATAL_ERROR "The compiler ${CMAKE_CXX_COMPILER} has no C++11/14 support. "
			"Please use a different C++ compiler.")
	endif ()

	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} \
		-Wall \
		-Werror \
		-Wextra \
		-fno-strict-aliasing \
		-Wcast-align \
		-Wconversion \
		-Wctor-dtor-privacy \
		-Wno-missing-braces \
		-Wnon-virtual-dtor \
		-Wold-style-cast \
		-Woverloaded-virtual \
		-Wpedantic \
		-Wshadow \
		-Wsign-conversion"
	)
#	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
#	https://stackoverflow.com/questions/13238511/xcode-clang-clang-warning-argument-unused-during-compilation-fcheck-new

	if (ENABLE_COVERAGE)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 -fprofile-arcs -ftest-coverage")
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --coverage")
	endif ()
endif ()
