
cmake_minimum_required(VERSION 3.0.0)

project(smela-tests CXX)

list(APPEND CATCH_CMAKE_ARGS
	"-DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/external"
	"-DNO_SELFTEST=true"
)

# Add catch library as an external project.
externalproject_add(
	catch
	# Root dir for entire project.
	PREFIX ${CMAKE_BINARY_DIR}/catch
	# URL of git repo.
	GIT_REPOSITORY https://github.com/catchorg/Catch2.git
	# Git branch name, commit id or tag.
	GIT_TAG v2.0.1
	# Force Git to output progress information during the clone step.
	GIT_PROGRESS 1
	# Arguments to CMake command line.
	CMAKE_ARGS ${CATCH_CMAKE_ARGS}
	# Wrap download in script to log output.
	LOG_DOWNLOAD 1
	# Never update automatically from the remote repository.
	UPDATE_DISCONNECTED 1
)

include_directories(smela-catch
    ${CMAKE_BINARY_DIR}/external/include
)

add_library(smela-catch STATIC Test.cpp)
add_dependencies(smela-catch catch)

function(do_test name)
	include_directories(smela-catch
	    ../modules/smela/include
	)
	add_executable(${name} ${name}.cpp)
	target_link_libraries(${name}
		smela
		smela-catch
	)
	add_dependencies(${name}
		catch
	)
	add_test(${name} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${name})
	# Group all tests under smela-tests.
	set_property(TARGET ${name} PROPERTY FOLDER "tests")
endfunction()

do_test(UserTests)
