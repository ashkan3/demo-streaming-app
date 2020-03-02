from boto3 import client as boto3_client
import logging
import json

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.WARN)

lambda_client = boto3_client('lambda')


def lambda_handler(event, context):
    logger.debug("Lambda was called with event {event}, and context: {context}".format(event=event, context=context))
    event_types = [{"stream":"custom-events-stream", "bucket": "data-files-demo","file":"custom_events.csv"},
                    {"stream": "groups-stream", "bucket": "data-files-demo", "file": "groups.csv"}
                   ]
    invoke_responses = []
    for event_type in event_types:
        invoke_responses.append(
            lambda_client.invoke(FunctionName="producer",
                                 InvocationType='Event',
                                 Payload=json.dumps(event_type))
        )
