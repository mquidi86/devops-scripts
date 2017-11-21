#!/bin/bash
export vpc_region="$1"
#export vpc_id="$2"

printf "%s\n" "Listing VPCs and their names for region ${vpc_region}" 

aws ec2 describe-vpcs --region "${vpc_region}" --query "Vpcs[*].[VpcId,Tags[?Key=='Name'].Value | [0]] " --output table
