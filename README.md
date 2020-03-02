# Demo Streaming Application

## How to deploy?
In order to deploy the application you'll need to populate ~/.aws/config or ~/.aws/credentials with desired AWS access and secret keys of the account that you wish to deploy the application in, and then simply from the root of the repo run: `./deploy.sh`

First time around it takes a bit longer for the deployment container to start as it needs to build the Docker image with required tooling to deploy the application. When the deployment container is run, it'll take you to an interactive terragrunt command line where you need to answer a few questions to deploy all of the infra.
