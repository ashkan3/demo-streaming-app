record_columns = [
  {
    mapping  = "$.id"
    name     = "ID"
    sql_type = "VARCHAR(64)"
  },
  {
    mapping  = "$.datetime"
    name     = "DATETIME"
    sql_type = "TIMESTAMP"
  },
  {
    mapping  = "$.userAgent"
    name     = "USER_AGENT"
    sql_type = "VARCHAR(128)"
  },
  {
    mapping  = "$.browserWithVersion"
    name     = "BROWSER"
    sql_type = "VARCHAR(16)"
  }
]

kinesis_analytics_app_name = "searches-data-analytics"
kinesis_stream             = "searches"
destination_s3             = "coveo-events-stream"

sql_code = <<EOF

CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" (INGEST_TIME TIMESTAMP, BROWSER VARCHAR(16), BROWSER_COUNT INT);
CREATE OR REPLACE PUMP "STREAM_PUMP" AS INSERT INTO "DESTINATION_SQL_STREAM"
SELECT STREAM STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '10' SECOND) AS INGEST_TIME,
    BROWSER,
    COUNT(*) AS BROWSER_COUNT FROM "SOURCE_SQL_STREAM_001"
GROUP BY BROWSER , STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '10' SECOND);

EOF
