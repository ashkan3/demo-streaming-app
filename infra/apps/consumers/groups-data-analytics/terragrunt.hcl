include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/kinesis-data-analytics"
}

dependencies {
  paths = ["../../streams/groups-stream", "../../../global/s3"]
}
