#!/usr/local/bin/python3

import sys
import boto3

aws_region = sys.argv[1]
queue_url = sys.argv[2]

client = boto3.client('sqs', region_name= aws_region )


response = client.receive_message(
    QueueUrl= queue_url ,
    MaxNumberOfMessages=2
)

print ( response )
