__confman::conf::install() {
    local dir="$1"
    local script="${dir}/${CONFMAN_SCRIPT_NAME}"

    ${CONFMAN_SHELL} "${tool_root}/lib/bootstrap.sh" ${script} install
    
    return $?
}

__confman::conf::update() {
    local dir="$1"
    local script="${dir}/${CONFMAN_SCRIPT_NAME}"

    ${CONFMAN_SHELL} "${tool_root}/lib/bootstrap.sh" ${script} update

    return $?
}

__confman::conf::clean() {
    local dir="$1"
}
