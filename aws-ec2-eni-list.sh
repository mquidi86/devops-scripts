#!/bin/bash
export aws_region="$1"
export vpc_id="$2"

printf "%s\n" "Listing Network Interfaces for VPC ${vpc_id} in region ${aws_region} " 

aws ec2 describe-network-interfaces --region "${aws_region}" \
--output table \
--filters Name=vpc-id,Values=${vpc_id} \
--query 'NetworkInterfaces[*].[NetworkInterfaceId,Description]'
