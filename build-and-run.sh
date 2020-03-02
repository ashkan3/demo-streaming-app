set -ex

docker build . -t build-tool
docker run -it \
           -v ~/.aws/:/root/.aws \
           -v $(pwd)/infra:/home/infra \
           build-tool bash -c "cd /home/infra/dev/apps && terragrunt apply-all"
