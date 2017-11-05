cmake_minimum_required(VERSION 3.0.0)

project(smela CXX)

configure_file(src/Version.h.in Version.h @ONLY)

set(SOURCES
	src/Main.cpp
	)

include_directories(
	src
	${CMAKE_CURRENT_BINARY_DIR}
	)

add_executable(${PROJECT_NAME}
	${SOURCES}
	)

target_link_libraries(${PROJECT_NAME}
	${CONAN_LIBS}
	)

cotire(${PROJECT_NAME})
