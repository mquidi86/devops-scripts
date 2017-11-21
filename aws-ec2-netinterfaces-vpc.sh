#!/bin/bash
export vpc_region="$1"
export vpc_id="$2"

printf "%s\n" "Listing Network interfaces of VPC ${vpc_id}" 

aws ec2 describe-network-interfaces --region "${vpc_region}" --filters Name=vpc-id,Values="${vpc_id}" --output=table \
	--query 'NetworkInterfaces[*].[NetworkInterfaceId,Attachment.InstanceId,Status,Association.PublicDnsName,Association.PublicIp]' 
