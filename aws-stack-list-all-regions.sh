#!/bin/bash
REGIONS_FILE=`dirname $0`/aws-regions.lst
stack_name=$1
printf "%s\n" "Listing CloudFormation Stacks for all regions" 

IFS="|"
while read stack_region region_name 
do
	aws cloudformation describe-stacks --region "${stack_region}" ${stack_name:+--stack-name} ${stack_name} \
	--output table \
	--query "Stacks[*].[to_string(\`${stack_region} \`),StackName,StackStatus,CreationTime,StackStatusReason,DisableRollback]" 2>/dev/null
done < ${REGIONS_FILE}
