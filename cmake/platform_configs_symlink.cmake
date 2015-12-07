find_package(Rabbits REQUIRED)

function(create_config_symlinks)
    get_property(__configs GLOBAL PROPERTY RABBITS_ALL_CONFIGS_LIST)

    set(__configs_dir ${CMAKE_CURRENT_SOURCE_DIR}/config/__auto_configs)
    file(REMOVE_RECURSE ${__configs_dir})
    file(MAKE_DIRECTORY ${__configs_dir})

    foreach(c IN LISTS __configs)
        file(RELATIVE_PATH c ${__configs_dir} ${c})
        execute_process(COMMAND ln -s "${c}" "${__configs_dir}")
    endforeach()
endfunction(create_config_symlinks)

function(create_platform_symlinks)
    get_property(__configs GLOBAL PROPERTY RABBITS_ALL_CONFIGS_LIST)

    set(_list_script ${RABBITS_LIST_PLATFORMS_SCRIPT_PATH})
    set(_list_exe ${RUBY_EXECUTABLE} "${_list_script}")

    execute_process(
        COMMAND ${_list_exe} ${__configs}
        OUTPUT_VARIABLE __platforms)

    foreach(p IN LISTS __platforms)
        execute_process(COMMAND ${CMAKE_SOURCE_DIR}/repos create-plat-symlink ${p})
    endforeach()
endfunction(create_platform_symlinks)

function(create_resource_symlinks)
    get_property(__res GLOBAL PROPERTY RABBITS_ALL_RES_LIST)

    set(__resource_dir ${CMAKE_CURRENT_BINARY_DIR}/.res)
    file(REMOVE_RECURSE ${__resource_dir})
    file(MAKE_DIRECTORY ${__resource_dir})

    foreach(r IN LISTS __res)
        set(inv_prop "RABBITS_RES_MAP_INV_${r}")
        set(dest_prop "RABBITS_RES_MAP_DEST_${r}")

        get_property(inv GLOBAL PROPERTY "${inv_prop}")
        get_property(dest GLOBAL PROPERTY "${dest_prop}")

        set(final_dest "${__resource_dir}/${inv}/${dest}")
        get_filename_component(final_dir ${final_dest} DIRECTORY)

        file(RELATIVE_PATH r ${final_dir} ${r})
        file(MAKE_DIRECTORY ${final_dir})
        execute_process(COMMAND ln -s "${r}" "${final_dest}")
    endforeach()
endfunction(create_resource_symlinks)
