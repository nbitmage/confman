#!/usr/bin/env bash

fn_exists() {
    LC_ALL=C type $1 2>/dev/null | grep -q 'shell function'
}

conf_script="$1"
sub_command="$2"

source ${conf_script}

if [ "${sub_command}" = "update" ]; then
    if fn_exists update; then
        update
    else
        clean
        install
    fi
else
    ${sub_command}
fi

