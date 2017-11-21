#!/bin/bash
printf "%s\n" "Listing CloudFormation Stacks for all regions" 

#aws rds describe-db-instances --region "${rds_region}" "${rds_name:+--db-instance-identifier}" ${rds_name} --query "DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus,DBSubnetGroup.VpcId,MasterUsername,DBName]" --output table
IFS="|"
while read stack_region region_name 
do
	aws cloudformation describe-stacks --region "${stack_region}" "${stack_name:+--stack-name}" ${stack_name} --query "Stacks[*].[StackName,StackStatus,CreationTime,StackStatusReason,DisableRollback]" --output table | sed "s?^?${stack_region} | ?" 
done < aws-regions.lst
