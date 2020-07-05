#!/bin/sh
cd $(dirname $0)
. ./settings.sh

deep_lint() {
  target_dirs=$(find ../../${base_dir} -type f -name "*.tf" -exec dirname {} \; | sort -u | grep -v ".terraform")
  for target in ${target_dirs}; do
    cd ${target}
    terraform init -input=false -no-color
    /usr/local/bin/tflint --deep --aws-region=${aws_region} --no-color
    cd $(dirname $0)
  done
}

deep_lint
