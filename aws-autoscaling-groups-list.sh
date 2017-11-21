#!/bin/bash
export aws_region="$1"
export asg_name="$2"

printf "%s\n" "Listing AutoScaling Groups" 

aws autoscaling describe-auto-scaling-groups --region "${aws_region}" ${asg_name:+--auto-scaling-group-names} ${asg_name} \
#	--output table \
	#--query "AutoScalingGroups[*].[AutoScalingGroupName,Status,LaunchConfigurationName,VPCZoneIdentifier,length(Instances)]"
