#!/bin/sh
cd `dirname $0`
. ./settings.sh


function delete_S3_bucket() {
  aws s3api delete-bucket --bucket ${bucket_name}
  printf '\033[91m%s\033[m\n' "deleted state bucket: ${bucket_name}."
}

function delete_dynamoDB() {
  aws dynamodb delete-table --table-name ${state_lock_table_name}
  printf '\033[91m%s\033[m\n' "deleted dynamoDB table: ${state_lock_table_name}."
}

delete_S3_bucket
delete_dynamoDB
