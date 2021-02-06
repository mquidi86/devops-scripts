#!/bin/bash
export bucket_name="$1"
export prefix="$2"

printf "%s\n" "Listing S3 Buckets" 

aws s3api list-objects-v2 \
--bucket $bucket_name \
--output table \
--prefix ${prefix} \
--query 'sort_by(Contents[],&LastModified )[].[*]'
#--prefix ${prefix:=/} \
