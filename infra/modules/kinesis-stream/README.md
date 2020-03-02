## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| env | Environment in which resources are going to be deployed. | `string` | n/a | yes |
| region | Region to deploy the resources to. | `string` | `"us-east-1"` | no |
| retention\_period | Length of time data records are accessible after they are added to the stream. The maximum value of a stream's retention period is 168 hours. Minimum value is 24. Default is 24. | `string` | `"24"` | no |
| shard\_count | The number of shards that the stream will use. Amazon has guidelines for specifying the Stream size that should be referenced when creating a Kinesis stream. | `string` | `"1"` | no |
| stream\_name | A name to identify the stream. This is unique to the AWS account and region the Stream is created in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| key\_arn | n/a |
| stream\_arn | n/a |

