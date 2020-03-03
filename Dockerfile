FROM python:3.7

ARG terraform_version=0.12.21
ARG terragrunt_version=v0.22.3
RUN apt-get update -y && \
    apt-get install vim -y

RUN wget https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip -O terraform.zip && \
    unzip terraform.zip && \
    rm terraform.zip && \
    mv terraform /usr/local/bin

RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/${terragrunt_version}/terragrunt_linux_386 -O terragrunt && \
    chmod +x terragrunt && \
    mv terragrunt /usr/local/bin

RUN pip3.7 install boto3 pandas awscli
