record_columns = [
  {
    mapping  = "$.searchId"
    name     = "SEARCH_ID"
    sql_type = "VARCHAR(64)"
  },
  {
    mapping  = "$.datetime"
    name     = "DATETIME"
    sql_type = "TIMESTAMP"
  },
  {
    mapping  = "$.groupName"
    name     = "GROUP_NAME"
    sql_type = "VARCHAR(8)"
  }
]

env                        = "dev"
kinesis_analytics_app_name = "group-data-analytics"
kinesis_stream             = "group-stream"
lambda_function_name       = "group-pre-processing"
lambda_handler             = "transformer.handler"
lambda_runtime             = "nodejs12.x"
lambda_timeout             = "60"
lambda_concurrency         = "5"
destination_s3             = "coveo-events-stream"

sql_code = <<EOF

CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" (GROUP_NAME VARCHAR(8), GROUP_NAME_COUNT INT);
CREATE OR REPLACE PUMP "STREAM_PUMP" AS INSERT INTO "DESTINATION_SQL_STREAM"
SELECT STREAM
    GROUP_NAME,
    COUNT(*) AS COUNTRY_COUNT FROM "SOURCE_SQL_STREAM_001"
GROUP BY GROUP_NAME , STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '60' SECOND);

EOF
