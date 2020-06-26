#!/bin/sh

base_dir="files"

function validate() {
  target_dirs=`find ${base_dir} -type f -name "*.tf" -exec dirname {} \; | sort -u`
  for target in ${target_dirs}
  do
    pushd ${target}
    terraform init
    terraform validate
    popd
  done
}

validate
