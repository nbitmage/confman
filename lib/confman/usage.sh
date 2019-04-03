
__confman::usage() {
cat <<-EOF
${CONFMAN_PROGRAM_NAME} ${CONFMAN_VERSION}
Usage: ${CONFMAN_PROGRAM_NAME} [OPTIONS] COMMAND

A simple config manager

Commands:
  install   Install all configurations
  update    Update all configurations to their latest version
  clean     Remove all configurations

Options:

EOF
}
