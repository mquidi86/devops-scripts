#!/bin/bash
export bucket_name="$*"

printf "%s\n" "Listing S3 Buckets" 

aws s3api list-buckets \
--output table \
--query 'sort_by(Buckets[],&CreationDate )[].[Name,CreationDate]'
