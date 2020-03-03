import sys
import time
import pandas as pd
import logging
import boto3
import uuid
from io import StringIO

logger = logging.getLogger(__name__)

PAYLOAD_NUM_OF_RECORD_LIMIT = 1000
PAYLOAD_BYTES_LIMIT = 1000000
NUM_OF_PAYLOADS_PER_SECOND = 2

class Producer:

    def __init__(self, stream_name, region="us-east-1"):
        self.stream_name = stream_name
        self.region = region
        self.kinesis = self.__create_client('kinesis', self.region)
        self.s3 = boto3.resource('s3')

    def __create_client(self, service, region):
        return boto3.client(service, region)

    def __get_file_from_s3(self, bucket_name, file_name):
        obj = self.s3.Object(bucket_name, file_name)
        body = obj.get()['Body'].read()
        return body

    def __get_number_of_shards(self):
        stream_config = self.kinesis.describe_stream(StreamName=self.stream_name)
        return len(stream_config.get("StreamDescription").get("Shards"))

    def __go_to_sleep(self):
        number_of_shards = self.__get_number_of_shards()
        seconds_to_sleep = 1.0 / (NUM_OF_PAYLOADS_PER_SECOND * number_of_shards)
        time.sleep(seconds_to_sleep)

    def __load_data(self, bucket_name, file_name):
        data_bytes = self.__get_file_from_s3(bucket_name, file_name)
        data_string = str(data_bytes, 'utf-8')
        data = StringIO(data_string)
        data_frame = pd.read_csv(data)
        return data_frame

    def send_to_kinesis(self, bucket_name, file_name):
        records = []
        current_bytes = 0
        row_count = 0

        data = self.__load_data(bucket_name, file_name)
        (rows, columns) = data.shape
        total_row_count = rows

        for _, row in data.iterrows():

            values = '|'.join(str(value) for value in row)
            encoded_values = bytes(values, 'utf-8')

            record = {
                "Data": encoded_values,
                "PartitionKey": uuid.uuid4().hex
            }

            records.append(record)
            current_bytes += sys.getsizeof(record)

            if self.__ready_to_send(len(records), current_bytes, row_count, total_row_count):
                response = self.kinesis.put_records(
                    Records=records,
                    StreamName=self.stream_name
                )

                records = []
                current_bytes = 0
                logger.info(response)
                self.__go_to_sleep()

            row_count += 1

    def __ready_to_send(self, records_length, current_bytes, row_count, total_row_count):
        send = False

        if records_length == int(PAYLOAD_NUM_OF_RECORD_LIMIT / NUM_OF_PAYLOADS_PER_SECOND):
            send = True

        elif current_bytes > int(PAYLOAD_BYTES_LIMIT / NUM_OF_PAYLOADS_PER_SECOND):
            send = True

        elif row_count == total_row_count - 1:
            send = True
        if send == True:
            print ("total row count:" + str(total_row_count) + "\t\t" + "row_count:" + str(row_count))
        return send


def lambda_handler(event, context):
    stream = event.get("stream")
    bucket_name = event.get("bucket")
    file_name = event.get("file")

    p = Producer(stream)
    p.send_to_kinesis(bucket_name, file_name)
