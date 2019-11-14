#!/usr/local/bin/python3

import sys
import boto3
import logging
from botocore.exceptions import ClientError
from base64 import b64decode

aws_region = sys.argv[1]
kms_key = sys.argv[2]
encrypted_value = sys.argv[3]

# Decrypt code should run once and variables stored outside of the function
# handler so that these are decrypted once per container
try:
    DECRYPTED = boto3.client('kms').decrypt(CiphertextBlob=b64decode( encrypted_value ))['Plaintext'].decode('utf-8')
    print ( "hola : " + DECRYPTED )
except ClientError as e:
    logging.error(e)
