cmake_minimum_required(VERSION 2.8)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(compiler_options)

enable_testing()
set(RABBITS_ENABLE_TESTING ON CACHE BOOL "Enable tests" FORCE)

execute_process(
	COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/repos repos-list
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
	OUTPUT_VARIABLE REPOS_LIST)

foreach(r IN LISTS REPOS_LIST)
	if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${r}.cmake)
		include(${r}.cmake)
	else()
		add_subdirectory(${r})
	endif()
endforeach()

include(platform_configs_symlink)

create_platform_symlinks()
create_config_symlinks()
create_resource_symlinks()
