data "aws_s3_bucket" "tf-state-storage-s3-test" {
    bucket = "tf-state-storage-s3-test"
}

data "aws_dynamodb_table" "dynamodb-tf-state-lock" {
  name = "tf-state-lock-dynamo"
}
