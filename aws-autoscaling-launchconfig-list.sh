#!/bin/bash
export aws_region="$1"

printf "%s\n" "Listing launch configurations in region ${aws_region}" 

aws autoscaling describe-launch-configurations --region ${aws_region} --query "sort_by(LaunchConfigurations[],&CreatedTime)[].[LaunchConfigurationName,CreatedTime,ImageId,KeyName]" --output table
