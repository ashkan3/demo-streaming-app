record_columns = [
  {
    mapping  = "$.customEventId"
    name     = "CUSTOM_EVENT_ID"
    sql_type = "VARCHAR(64)"
  },
  {
    mapping  = "$.country"
    name     = "COUNTRY"
    sql_type = "VARCHAR(16)"
  }
]

kinesis_analytics_app_name = "demo-app"
name_prefix                = "test"
kinesis_stream             = "data-stream-demo"
env                        = "dev"
key_arn                    = "arn:aws:kms:us-east-1:206612368495:key/3d8f2360-a2d9-4a52-8a35-31e1de35179d"
lambda_name                = "data-transformation"
lambda_version             = "$LATEST"
sql_code                   = "CREATE OR REPLACE STREAM \"DESTINATION_SQL_STREAM\" (COUNTRY VARCHAR(16), COUNTRY_COUNT INT);\nCREATE OR REPLACE PUMP \"STREAM_PUMP\" AS INSERT INTO \"DESTINATION_SQL_STREAM\";\nSELECT STREAM COUNTRY, COUNT(*) AS COUNTRY_COUNT FROM \"SOURCE_SQL_STREAM_001\" GROUP BY COUNTRY , STEP(\"SOURCE_SQL_STREAM_001\".ROWTIME BY INTERVAL '60' SECOND); "