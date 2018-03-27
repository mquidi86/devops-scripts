#!/bin/bash
export stack_region="$1"
export stack_name="$2"
export stack_item="$3"

printf "%s\n" "Listing CloudFormation Stacks ${stack_name}" 

aws cloudformation describe-stack-events --region "${stack_region}" "${stack_name:+--stack-name}" ${stack_name} ${max_output:+--max-items} ${max_output} \
--output table \
--query "sort_by(StackEvents[?LogicalResourceId==\`${stack_item}\`],&Timestamp)[].[Timestamp,ResourceStatus,ResourceStatusReason]"
