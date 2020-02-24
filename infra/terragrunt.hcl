remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "demo-app-terraform-state-files"
    key = "${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table = "terraform-locks"
    encrypt = true
    region = "us-east-1"
  }
}
