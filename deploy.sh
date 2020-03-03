set -ex

AWS_CREDS_DIR=$1
if [ -z "${AWS_CREDS_DIR}" ];then
  AWS_CREDS_DIR=~/.aws
fi

docker build . -t build-tool
docker run -it \
           -v ${AWS_CREDS_DIR}/:/root/.aws \
           -v $(pwd)/infra:/home/infra \
           build-tool bash -c "cd /home/infra/dev/apps && terragrunt apply-all"
