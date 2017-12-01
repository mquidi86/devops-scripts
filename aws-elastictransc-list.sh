#!/bin/bash
export aws_region="$1"

printf "%s\n" "Listing AMIs for region ${aws_region}" 

aws elastictranscoder list-pipelines --region "${aws_region}" --output table \
--query "sort_by(Pipelines[],&Status)[].[Name,Id,Arn,Status]"
#--query "sort_by(Pipelines[],&Status)[].[Name,Id,Arn,Status,InputBucket,OutputBucket]"
