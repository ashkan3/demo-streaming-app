import pandas as pd
import logging
import boto3
import uuid
import time
import sys

logger = logging.getLogger(__name__)

class Producer:

    def __init__(self, stream_name, region="us-east-1"):
        self.stream_name = stream_name
        self.region = region
        self.kinesis = self.__create_client('kinesis', self.region)

    def __create_client(self, service, region):
        return boto3.client(service, region)

    def __load_data(self, file_name):
        df = pd.read_csv(file_name)
        return df

    def send_to_kinesis(self, file_name):
        records = []
        current_bytes = 0
        row_count = 0

        data = self.__load_data(file_name)
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

            if self.__ready_to_send(len(records), current_bytes, row_count, total_row_count):

                response = self.kinesis.put_records(
                    Records=records,
                    StreamName=self.stream_name
                )

                records = []
                current_bytes = 0
                logger.info(response)

            row_count += 1

    def __ready_to_send(self, records_length, current_bytes, row_count, total_row_count):
        send = False
        if records_length == 500:
            send = True

        elif current_bytes > 50000:
            send = True

        elif row_count == total_row_count - 1:
            send = True
        return send

if __name__ == "__main__":
    csv_file = str(sys.argv[1])
    stream = str(sys.argv[2])
    p = Producer(stream)
    p.send_to_kinesis(csv_file)
