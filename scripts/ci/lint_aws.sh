#!/bin/sh
cd $(dirname $0)
. ./settings.sh

deep_lint() {
  target_dirs=$(find ../../${base_dir} -type f -name "*.tf" -exec dirname {} \; | sort -u)
  for target in ${target_dirs}; do
    cd ${target}
    terraform init -input=false -no-color
    tflint --deep --aws-region=${aws_region} --no-color
  done
}

deep_lint
