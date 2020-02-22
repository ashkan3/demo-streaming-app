FROM python:3.7

RUN apt-get update -y && \
    apt-get install vim -y && \
    apt install default-jre
RUN pip3.7 install boto3 amazon_kclpy pandas

#ADD producer.py /home
