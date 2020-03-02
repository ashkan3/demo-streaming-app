set -ex

docker build . -t build-tool
docker run -it -v ~/.aws/:/root/.aws \
               -v $(pwd)/data-files:/home/data-files \
               -v $(pwd)/src:/home -v ~/.ssh:/root/.ssh \
               -v $(pwd)/infra:/home/infra build-tool bash -c "cd /home/infra/dev/apps && terragrunt apply-all"
