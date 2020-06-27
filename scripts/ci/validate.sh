#!/bin/sh
cd `dirname $0`
. ./settings.sh

function validate() {
  target_dirs=`find ../../${base_dir} -type f -name "*.tf" -exec dirname {} \; | sort -u`
  for target in ${target_dirs}
  do
    cd ${target}
    terraform init -input=false -no-color
    terraform validate -no-color
  done
}

validate
