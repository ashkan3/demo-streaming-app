## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | n/a |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| concurrency | The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. | `string` | n/a | yes |
| description | Description of what the Lambda Function does. | `string` | `"Pre-processing Lambda function."` | no |
| env | Environment in which resources are going to be deployed. | `string` | n/a | yes |
| filename | Name of Lambda source file. | `string` | n/a | yes |
| function\_name | A unique name for the Lambda Function. | `string` | n/a | yes |
| handler | The function entrypoint in Lambda code. | `string` | n/a | yes |
| iam\_policy\_path | Relative path to the IAM policy template file. | `string` | n/a | yes |
| kinesis\_streams | List of Kinesis streams that producer Lambda function needs to have access to. | `list(string)` | `[]` | no |
| layer\_compatible\_runtimes | Compatible runtimes with this Lambda layer. | `list(string)` | n/a | yes |
| layer\_name | Name of Lambda layer. | `string` | n/a | yes |
| layer\_s3\_bucket | Name of S3 bucket where Lambda layer is stored. | `string` | n/a | yes |
| layer\_s3\_key | Name of the Layer zip file stored in s3. | `string` | n/a | yes |
| log\_retention | Specifies the number of days you want to retain log events in the specified log group. | `string` | `"1"` | no |
| memory\_size | Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. | `string` | `"128"` | no |
| region | Region to deploy the resources to. | `string` | `"us-east-1"` | no |
| runtime | Lambda function runtime, e.g. python3.7, java11. | `string` | n/a | yes |
| timeout | The amount of time your Lambda Function has to run in seconds. | `string` | `"5"` | no |

## Outputs

No output.

