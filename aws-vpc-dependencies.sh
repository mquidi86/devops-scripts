#!/bin/bash
export vpc_region="$1"
export vpc_id="$2"
export AWS_DEFAULT_OUTPUT=table

printf "%s\n" "listing network interfaces of VPC ${vpc_id}"
aws ec2 describe-network-interfaces --region ${vpc_region} --filters Name=vpc-id,Values="${vpc_id}" --query "NetworkInterfaces[*].[NetworkInterfaceId,OwnerId,Description]"

printf "%s\n" "listing security groups of VPC ${vpc_id}"
aws ec2 describe-security-groups --region ${vpc_region} --filters Name=vpc-id,Values="${vpc_id}" --query "SecurityGroups[*].[GroupId,GroupName]"

printf "%s\n" "listing Internet Gateways attached to VPC ${vpc_id}"
aws ec2 describe-internet-gateways --region ${vpc_region} --filters Name=attachment.vpc-id,Values="${vpc_id}" --query "InternetGateways[*].[InternetGatewayId]" 

printf "%s\n" "listing Route Tables attached to VPC ${vpc_id}"
aws ec2 describe-route-tables --region ${vpc_region} --filters Name=vpc-id,Values="${vpc_id}" --query "RouteTables[*].[RouteTableId]"

printf "%s\n" "listing Subnets attached to VPC ${vpc_id}"
aws ec2 describe-subnets --region ${vpc_region} --filters Name=vpc-id,Values="${vpc_id}" --query "Subnets[*].[SubnetId]"
