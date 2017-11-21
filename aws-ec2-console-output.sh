#!/bin/bash
export aws_region="$1"
export instance_id="$2"

printf "%s\n" "Listing EC2 instances for region ${aws_region}" 

aws ec2 get-console-output --region "${aws_region}" --instance-id "${instance_id}" \
--output text \
--query 'Output'
