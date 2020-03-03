# Demo Streaming Application

## How to deploy?
### Prerequisites
1. CSV event files will need to be uploaded to an S3 bucket and then name of that bucket should be assigned to `events_bucket` variable in [this file](infra/dev/apps/producer/actor/terraform.tfvars).
1. Write desired AWS Access and Secret Keys of the desired AWS account you'd like to deploy the application in, in a file named `config` or file `credentials` anywhere on your machine.
 
### Now Deploy  
Run `./deploy.sh <path_to_aws_creds_directory>`. If _path_to_aws_creds_directory_ is not passed, script will use `~/.aws` as its default directory to find AWS credentials. 

First time around it takes a bit longer for the deployment container to start as it needs to build the Docker image with required tooling to deploy the application. When the deployment container is run, it'll take you to an interactive terragrunt command line where you need to answer a few questions to deploy all of the infra.

### How to Produce Events?
When deployment is done, you'll need to call the wrapper Lambda function that was created with an event similar to the following:
````
[
 {
    "stream": "custom-events-stream",
    "bucket": "data-files-demo",
    "file":"custom_events.csv"
 },
 {
    "stream": "groups-stream",
    "bucket": "data-files-demo",
    "file": "groups.csv"
 }
]
````

## How does it work?
![Application's Diagram](images/diagram.png)

At the beginning of the pipeline Wrapper Lambda calls Producer Lambdas with the name of event file and the S3 bucket to find that file in and the Kinesis Stream to send that event type to. Each producer Lambda in this application is responsible to produce an event type.
In this design each event type is going to a separate Kinesis Stream, and from there events are processed by a pre-processing Lambda function if desired by the Kinesis Analytics Consumer. When events are consumed by Kinesis Analytics, the result will be pushed to Kinesis Firehose dedicated to that event type where they can be pushed to S3 or Redshift for further use.