declare -g sub_command=""

__confman::core::parse_arguments() {
    for arg in "$@"
    do
        case "${arg}" in
            --help)
                __confman::usage
                exit 0
                ;;
            install | update | clean | check)
                sub_command=${arg}
                ;;
            *)
                ;;
        esac
    done
}

__confman::core::exec() {
    local arguments="$1"
    
    __confman::core::parse_arguments ${arguments}
    
    if [ -z ${sub_command} ]; then
        __confman::usage
        exit 1
    else
        __confman::commands::${sub_command}
        exit $?
    fi
}

__confman::core::target_conf_dirs() {
    local candidate_dirs=($(find ${CONFMAN_TARGET_DIR} -mindepth 1 -maxdepth 1 -type d))
    local result_dirs=()
    for dir in "${candidate_dirs[@]}"
    do
        if [ -f "${dir}/${CONFMAN_SCRIPT_NAME}" ]; then
            result_dirs=(${result_dirs} ${dir})
        fi
    done
    echo ${result_dirs[@]}
}

__confman::core::behind_conf_dirs() {
    local target_dirs=($(__confman::core::target_conf_dirs))
    local result=()
    for dir in "${target_dirs[@]}"
    do
        if [ "$(__confman::cache::dir_status ${dir})" != "latest" ]; then
            result=(${result} ${dir})
        fi
    done
    echo ${result[@]}
}
