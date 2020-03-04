include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/kinesis-data-analytics"
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${get_terragrunt_dir()}/../../../env.tfvars"
    ]
  }
}

dependencies {
  paths = ["../../streams/searches", "../../../../global/s3"]
}
