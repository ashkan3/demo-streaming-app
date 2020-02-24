set -ex

docker build . -t coveo-app
docker run -it -v /Users/ash/.aws/:/root/.aws -v $(pwd)/data-files:/home/data-files -v $(pwd)/src:/home -v /Users/ash/.ssh:/root/.ssh -v $(pwd)/infra:/home/infra coveo-app bash
