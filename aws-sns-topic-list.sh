#!/bin/bash
export aws_region="$1"
#export ami_name="$2"

printf "%s\n" "Listing SNS Topics for region ${aws_region}" 

aws sns list-topics --region "${aws_region}" --output table \
--query "Topics[].[TopicArn]"
