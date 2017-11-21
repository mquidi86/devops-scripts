#!/bin/bash
export aws_region="$1"
export asg_name="$2"

aws autoscaling describe-auto-scaling-groups --region "${aws_region}" ${asg_name:+--auto-scaling-group-names} ${asg_name} --output table \
	--query "AutoScalingGroups[*].Instances[*]"
