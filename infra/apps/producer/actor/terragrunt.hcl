include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/lambda"
}

dependencies {
  paths = ["../../streams/custom-events-stream", "../../streams/groups-stream"]
}
