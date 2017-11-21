#!/bin/bash
export stack_region="$1"
export stack_name="$2"

printf "%s\n" "Listing CloudFormation Stacks ${stack_name} for region ${stack_region}" 

#aws rds describe-db-instances --region "${rds_region}" "${rds_name:+--db-instance-identifier}" ${rds_name} --query "DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus,DBSubnetGroup.VpcId,MasterUsername,DBName]" --output table
aws cloudformation describe-stacks --region "${stack_region}" "${stack_name:+--stack-name}" ${stack_name} --query "Stacks[*].[StackName,StackStatus,CreationTime,StackStatusReason,DisableRollback]" --output table
