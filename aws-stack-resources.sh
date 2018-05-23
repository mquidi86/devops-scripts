#!/bin/bash
export aws_region="$1"
export stack_name="$2"

printf "%s\n" "Listing CloudFormation Stacks ${stack_name} for region ${aws_region}" 

aws cloudformation describe-stack-resources --region "${aws_region}" "${stack_name:+--stack-name}" ${stack_name} --query "StackResources[*].[LogicalResourceId,PhysicalResourceId,ResourceStatus,ResourceType,StackName,Timestamp]" --output table
