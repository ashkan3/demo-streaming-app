## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | n/a |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| destination\_s3 | Destinaiton S3 bucket for processed records coming from Kinesis Data Analytics app. | `string` | n/a | yes |
| destination\_s3\_buffer\_interval | Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination. | `string` | `"300"` | no |
| destination\_s3\_buffer\_size | "Buffer incoming data to the specified size, in MBs, before delivering it to the destination. The default value is 5.<br>We recommend setting SizeInMBs to a value greater than the amount of data you typically ingest into the delivery stream<br>in 10 seconds." | `string` | `"5"` | no |
| destination\_s3\_compression\_format | "The compression format. If no value is specified, the default is UNCOMPRESSED. Other supported values are GZIP, ZIP & Snappy. If the destination is redshift you cannot use ZIP or Snappy." | `string` | `"UNCOMPRESSED"` | no |
| env | Environment in which resources are going to be deployed. | `string` | n/a | yes |
| kinesis\_analytics\_app\_name | Name of kinesis data analytics application that will be created. | `string` | n/a | yes |
| kinesis\_stream | Name of the Kinesis stream to connect to. | `string` | n/a | yes |
| lambda\_concurrency | The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. | `string` | n/a | yes |
| lambda\_description | Description of what the Lambda Function does. | `string` | `"Pre-processing Lambda function."` | no |
| lambda\_event\_age\_in\_seconds | Maximum age of a request that Lambda sends to a function for processing in seconds. Valid values between 60 and 21600. | `number` | `100` | no |
| lambda\_filename | Name of Lambda source file. | `string` | n/a | yes |
| lambda\_function\_name | A unique name for the Lambda Function. | `string` | n/a | yes |
| lambda\_handler | The function entrypoint in Lambda code. | `string` | n/a | yes |
| lambda\_layer\_compatible\_runtimes | A list of Runtimes this layer is compatible with. Up to 5 runtimes can be specified. | `list(string)` | n/a | yes |
| lambda\_layer\_name | A unique name for your Lambda Layer | `string` | n/a | yes |
| lambda\_layer\_s3\_bucket | The S3 bucket location containing the function's deployment package. | `string` | n/a | yes |
| lambda\_layer\_s3\_key | The S3 key of an object containing the function's deployment package. | `string` | n/a | yes |
| lambda\_log\_retention | Specifies the number of days you want to retain log events in the specified log group. | `string` | `"1"` | no |
| lambda\_memory\_size | Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. | `string` | `"128"` | no |
| lambda\_publish | Whether to publish creation/change as new Lambda Function Version. Defaults to true. | `bool` | `true` | no |
| lambda\_retry\_attempts | Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2. | `number` | `0` | no |
| lambda\_runtime | Lambda function runtime, e.g. python3.7, java11. | `string` | n/a | yes |
| lambda\_timeout | The amount of time your Lambda Function has to run in seconds. | `string` | `"5"` | no |
| lambda\_version | Version of Lambda function to call for pre-processing records. | `string` | `"$LATEST"` | no |
| name\_prefix | The Name Prefix to use when creating an in-application stream. | `string` | `"SOURCE_SQL_STREAM"` | no |
| output\_record\_format\_type | The Format Type of the records on the output stream. Can be CSV or JSON. | `string` | `"JSON"` | no |
| output\_stream\_name | The Name of the in-application stream. | `string` | `"DESTINATION_SQL_STREAM"` | no |
| parallelism\_count | The number of Parallel in-application streams to create. | `string` | `1` | no |
| record\_columns | The Record Column mapping for the streaming source data element. | `list(map(string))` | n/a | yes |
| record\_encoding | The Encoding of the record in the streaming source. | `string` | `"UTF-8"` | no |
| region | Region to deploy the resources to. | `string` | `"us-east-1"` | no |
| sql\_code | SQL Code to transform input data, and generate output. | `string` | n/a | yes |

## Outputs

No output.

