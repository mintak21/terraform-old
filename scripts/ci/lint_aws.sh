#!/bin/sh
SCRIPT_DIR=$(
  cd $(dirname $0)
  pwd
)
cd ${SCRIPT_DIR}
. ./settings.sh

deep_lint() {
  target_dirs=$(find ../../${base_dir} -type f -name "*.tf" -exec dirname {} \; | sort -u | grep -v ".terraform")
  for target in ${target_dirs}; do
    cd ${target}
    terraform init -input=false -no-color
    /usr/local/bin/tflint --deep --aws-region=${aws_region} --no-color
    cd ${SCRIPT_DIR}
  done
}

deep_lint
