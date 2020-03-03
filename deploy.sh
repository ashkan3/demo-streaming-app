set -ex

read -p "Enter the path to your AWS config or credentials file (defaults to ~/.aws):" AWS_CREDS_DIR
if [ -z "${AWS_CREDS_DIR}" ];then
  AWS_CREDS_DIR=~/.aws
fi

docker build . -t build-tool
docker run -it \
           -v ${AWS_CREDS_DIR}/:/root/.aws \
           -v $(pwd)/infra:/home/infra \
           build-tool bash -c "cd /home/infra/dev/apps && terragrunt apply-all"
