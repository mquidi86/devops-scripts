#!/usr/local/bin/python3

import sys
import boto3
import logging
from botocore.exceptions import ClientError

aws_region = sys.argv[1]
s3_bucket = sys.argv[2]
s3_object = sys.argv[3]

s3_client = boto3.client('s3')
try:
    response = s3_client.generate_presigned_url('get_object',
                                                Params={'Bucket': s3_bucket,
                                                        'Key': s3_object},
                                                ExpiresIn=300)
except ClientError as e:
    logging.error(e)

print ( response )
