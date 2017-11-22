#!/bin/bash
export aws_region="$1"
export asg_name="$2"
export max_output="$3"

printf "%s\n" "Activity History for AutoScaling Groups for region ${aws_region}${asg_name:+ for }${asg_name}" 

test -z "${asg_name}" && optionalOutput="AutoScalingGroupName,"
aws autoscaling describe-scaling-activities --region "${aws_region}" ${asg_name:+--auto-scaling-group-name }${asg_name} ${max_output:+--max-items }${max_output}  \
--output table \
--query "sort_by(Activities[*],&StartTime)[].[${optionalOutput}StatusCode,StartTime,EndTime,StatusReason,Description]"
