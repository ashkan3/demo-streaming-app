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

env                        = "dev"
kinesis_analytics_app_name = "custom-events-data-analytics"
kinesis_stream             = "custom-events-stream"
lambda_filename            = "transformer.js"
lambda_function_name       = "custom-events-pre-processing"
lambda_handler             = "transformer.handler"
lambda_runtime             = "nodejs12.x"
lambda_timeout             = "60"
lambda_concurrency         = "5"
destination_s3             = "coveo-events-stream"

sql_code = <<EOF

CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" (COUNTRY VARCHAR(16), COUNTRY_COUNT INT);
CREATE OR REPLACE PUMP "STREAM_PUMP" AS INSERT INTO "DESTINATION_SQL_STREAM"
SELECT STREAM
    COUNTRY,
    COUNT(*) AS COUNTRY_COUNT FROM "SOURCE_SQL_STREAM_001"
GROUP BY COUNTRY , STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '60' SECOND);

EOF
