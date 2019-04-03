__confman::commands::check() {
    local conf_dirs=$(__confman::core::target_conf_dirs)
    
    for dir in ${conf_dirs}
    do
        local conf_name=$(basename ${dir})
        local conf_status=$(__confman::cache::dir_status ${dir})
        __confman::utils::io::log info "${conf_name}: ${conf_status}"
    done
    
    # return a number of upgradable configurations as status
    local behind_conf_dirs=($(__confman::core::behind_conf_dirs))
    return ${#behind_conf_dirs[@]}
}

__confman::commands::install() {
    local conf_dirs=$(__confman::core::target_conf_dirs)
    local exit_status=0
    
    for dir in ${conf_dirs}
    do
        local conf_name=$(basename ${dir})
        local conf_status=$(__confman::cache::dir_status ${dir})
        local conf_status_after=""
        local result=""

        case "${conf_status}" in
            not_installed | behind)

                if [ "${conf_status}" = "not_installed" ]; then
                    __confman::conf::install ${dir}
                else
                    __confman::conf::update ${dir}
                fi

                if [ "$?" = "0" ]; then
                    __confman::cache::save_latest_commit_hash ${dir}
                    conf_status_after="latest"
                else
                    exit_status=1
                    conf_status_after="error"
                fi
                ;;
            *)
                conf_status_after="unchanged"
                ;;
        esac

        __confman::utils::io::log info "${conf_name}: ${conf_status} -> ${conf_status_after}"
    done

    return ${exit_status}
}
