
# Clang-Tidy
# --------------------
#
# clang-tidy is a clang-based C++ “linter” tool.
# Its purpose is to provide an extensible framework for diagnosing
# and fixing typical programming errors, like style violations,
# interface misuse, or bugs that can be deduced via static analysis.
# clang-tidy is modular and provides a convenient interface for writing new checks.
#

if (ENABLE_CLANG_TIDY)
	return ()
endif ()

if (MSVC)
	message(WARNING "Coverage does not work on Windows")
else ()
	find_program(CLANG_TIDY_BIN clang-tidy-4.0)

	if (CLANG_TIDY_BIN STREQUAL "CLANG_TIDY_BIN-NOTFOUND")
		message(FATAL_ERROR "Unable to locate clang-tidy-4.0")
	endif ()

	find_program(RUN_CLANG_TIDY_BIN run-clang-tidy-4.0.py)

	if (RUN_CLANG_TIDY_BIN STREQUAL "RUN_CLANG_TIDY_BIN-NOTFOUND")
		message(FATAL_ERROR "Unable to locate run-clang-tidy-4.0.py")
	endif ()

	list(APPEND RUN_CLANG_TIDY_BIN_ARGS
		-clang-tidy-binary ${CLANG_TIDY_BIN}
		-header-filter=.*
		-checks=clan*,cert*,misc*,perf*,cppc*,read*,mode*,-cert-err58-cpp,-misc-noexcept-move-constructor
	)

	add_custom_target(tidy
		COMMAND ${RUN_CLANG_TIDY_BIN} ${RUN_CLANG_TIDY_BIN_ARGS}
		COMMENT "Running clang-tidy"
	)
endif ()
