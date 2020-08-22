#!/bin/sh
. ./settings.sh
SCRIPT_DIR=$(
  cd "$(dirname $0)" || {
    echo "Failed to exec change directory command"
    exit 1
  }
  pwd
)
cd "${SCRIPT_DIR}" || {
  echo "Failed to exec change directory command"
  exit 1
}

message() {
  envs="$(pwd | rev | cut -d '/' -f 1 | rev)"
  now="$(TZ=-9 date +"%Y/%m/%d %H:%M:%S")"
  msg=$(
    cat <<EOF
### Target Environment\n
${envs}\n
### Planned Date\n
${now}
EOF
  )
  echo "${msg}"
}

plan() {
  target_dirs="$(find ../../"${base_dir}" -type f -name "*.tf" -exec dirname {} \; | sort -u | grep -v ".terraform")"
  for target in ${target_dirs}; do
    cd "${target}" || return
    terraform init -input=false -no-color
    terraform plan -input=false -no-color |
      /usr/local/bin/tfnotify --config "${SCRIPT_DIR}/../../cicd/tfnotify.yml" plan --message "$(message)"
    cd "${SCRIPT_DIR}" || return
  done
}

plan
