include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/kinesis-stream"
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${get_terragrunt_dir()}/../../../env.tfvars"
    ]
  }
}
