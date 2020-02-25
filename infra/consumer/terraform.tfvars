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

kinesis_analytics_app_name = "analytics-demo-app"
name_prefix                = "SOURCE_SQL_STREAM"
kinesis_stream             = "data-stream-demo"
env                        = "dev"
lambda_name                = "data-transformation"
lambda_version             = "$LATEST"
sql_code                   = "CREATE OR REPLACE STREAM \"DESTINATION_SQL_STREAM\" (COUNTRY VARCHAR(16), COUNTRY_COUNT INT);\nCREATE OR REPLACE PUMP \"STREAM_PUMP\" AS INSERT INTO \"DESTINATION_SQL_STREAM\"\nSELECT STREAM\n\tCOUNTRY,\n\tCOUNT(*) AS COUNTRY_COUNT FROM \"SOURCE_SQL_STREAM_001\"\nGROUP BY COUNTRY , STEP(\"SOURCE_SQL_STREAM_001\".ROWTIME BY INTERVAL '60' SECOND);"
