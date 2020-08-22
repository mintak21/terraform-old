#!/bin/sh
cd "$(dirname $0)" || exit 1
. ./settings.sh

create_S3_bucket() {
  # バケット作成
  aws s3api create-bucket --bucket "${bucket_name}" --create-bucket-configuration LocationConstraint="${region}"
  # バージョニングの有効化
  aws s3api put-bucket-versioning --bucket "${bucket_name}" --versioning-configuration Status=Enabled
  # バケットの暗号化
  aws s3api put-bucket-encryption --bucket "${bucket_name}" \
    --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'
  # ブロックパブリックアクセス
  aws s3api put-public-access-block --bucket "${bucket_name}" \
    --public-access-block-configuration '{
              "BlockPublicAcls"      : true,
              "IgnorePublicAcls"     : true,
              "BlockPublicPolicy"    : true,
              "RestrictPublicBuckets": true
            }'
  # タグ付け
  aws s3api put-bucket-tagging --bucket "${bucket_name}" \
    --tagging 'TagSet=[{Key=description,Value=manage mintak-terraformer tfstate}]'
  printf '\033[36m%s\033[m\n' "created state bucket: ${bucket_name}."
}

create_dynamoDB() {
  aws dynamodb create-table \
    --table-name "${state_lock_table_name}" \
    --attribute-definitions '[{"AttributeName":"LockID","AttributeType": "S"}]' \
    --key-schema '[{"AttributeName":"LockID","KeyType": "HASH"}]' \
    --provisioned-throughput '{"ReadCapacityUnits": 1, "WriteCapacityUnits": 1}'
  printf '\033[36m%s\033[m\n' "created dynamoDB table for lock: ${state_lock_table_name}."
}

create_S3_bucket
create_dynamoDB
