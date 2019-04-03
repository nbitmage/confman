__confman::utils::io::log() {
  local level="${1^^}"
  shift
  local body="$@"

  local msg="[${level}] ${body}"
  
  case "${level}" in
    DEBUG)
      if [ "${DBEUG}" = "1" ]; then
        echo "${msg}" >&1
      fi
      ;;
    INFO)
      echo "${msg}" >&1
      ;;
    ERROR)
      echo "${msg}" >&2
      ;;
  esac
  
  return 0
}
