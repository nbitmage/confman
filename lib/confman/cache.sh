__confman::cache::hash_keeper_path() {
  local dir="$1"
  echo "${CONFMAN_CACHE_DIR}/$(basename ${dir})"
}

__confman::cache::get_current_commit_hash() {
  local dir="$1"
  local hash=""
  local hash_keeper=$(__confman::cache::hash_keeper_path ${dir})

  if [ -f ${hash_keeper} ]; then
    hash="$(cat ${hash_keeper})"
  fi

  echo ${hash}
}

__confman::cache::get_latest_commit_hash() {
  local dir="$1"
  local cur_dir=$(pwd)
  
  cd ${dir}
  echo "$(git log --pretty=%H .)"
  cd ${cur_dir}
}

__confman::cache::save_latest_commit_hash() {
  local dir="$1"
  local hash_keeper=$(__confman::cache::hash_keeper_path ${dir})
  echo "$(__confman::cache::get_latest_commit_hash ${dir})" > ${hash_keeper}
}

__confman::cache::remove_hash_keeper() {
  local dir="$1"
  local hash_keeper=$(__confman::cache::hash_keeper_path ${dir})
  if [ -f ${hash_keeper} ]; then
    rm -f ${hash_keeper}
  fi
}

__confman::cache::dir_status() {
  local dir="$1"
  local current_hash=$(__confman::cache::get_current_commit_hash ${dir})
  local latest_hash=$(__confman::cache::get_latest_commit_hash ${dir})

  if [ -z "${current_hash}" ]; then
    echo "not_installed"
    return 2
  fi
  
  if [ "${current_hash}" = "${latest_hash}" ]; then
    echo "latest"
    return 0
  else
    echo "behind"
    return 1
  fi
}
