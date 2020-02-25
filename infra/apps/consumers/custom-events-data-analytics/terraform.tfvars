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
name_prefix                = "SOURCE_SQL_STREAM"
kinesis_stream             = "custom-events-stream"
lambda_version             = "$LATEST"
function_name              = "custom-events-pre-processing"
filename                   = "lambda.zip"
description                = "pre-processing Lambda function"
handler                    = "transformer.handler"
runtime                    = "nodejs12.x"
lambda_timeout             = "60"
concurrency                = "5"
sql_code                   = <<EOF

CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" (COUNTRY VARCHAR(16), COUNTRY_COUNT INT);
CREATE OR REPLACE PUMP "STREAM_PUMP" AS INSERT INTO "DESTINATION_SQL_STREAM"
SELECT STREAM
    COUNTRY,
    COUNT(*) AS COUNTRY_COUNT FROM "SOURCE_SQL_STREAM_001"
GROUP BY COUNTRY , STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '60' SECOND);

EOF
