from boto3 import client as boto3_client
import logging
import json

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.WARN)

lambda_client = boto3_client('lambda')


def lambda_handler(event, context):
    logger.debug("Lambda was called with event {event}, and context: {context}".format(event=event, context=context))
    invoke_responses = []
    for event_type in event:
        invoke_responses.append(
            lambda_client.invoke(FunctionName="producer",
                                 InvocationType='Event',
                                 Payload=json.dumps(event_type))
        )
