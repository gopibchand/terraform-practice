terraform {
  backend "s3" {
    bucket = "my-test-tygde"
    region = "ap-south-1"
    key = "testingstate/state.tf"
  }
}