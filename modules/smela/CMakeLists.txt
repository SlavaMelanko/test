
cmake_minimum_required(VERSION 3.0.0)

project(smela CXX)

configure_file(include/smela/Version.h.in Version.h @ONLY)

file(GLOB_RECURSE HEADERS "include/*.h")
file(GLOB_RECURSE SOURCES "src/*.cpp")

add_library(${PROJECT_NAME}
	${CMAKE_CURRENT_BINARY_DIR}/Version.h
	${HEADERS}
	${SOURCES}
)

target_link_libraries(${PROJECT_NAME}
	${CONAN_LIBS}
)

target_include_directories(${PROJECT_NAME}
	PUBLIC
		$<BUILD_INTERFACE:
			${CMAKE_CURRENT_BINARY_DIR}
			${CMAKE_CURRENT_SOURCE_DIR}/include
		>
		$<INSTALL_INTERFACE:include>
	PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src
	)

cotire(${PROJECT_NAME})
