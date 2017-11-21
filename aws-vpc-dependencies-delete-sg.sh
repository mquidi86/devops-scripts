#!/bin/bash
export vpc_region="$1"
export vpc_id="$2"

aws ec2 describe-network-interfaces --region ${vpc_region} --filters Name=vpc-id,Values="${vpc_id}" --query "NetworkInterfaces[*].[NetworkInterfaceId,Attachment.AttachmentId]" --output text | while read eni_id eni_attach_id
do
	printf "%s\n" "Detaching Network Interface ${eni_id}"
	aws ec2 detach-network-interface --region ${vpc_region} --no-dry-run --attachment-id ${eni_attach_id}
	printf "%s\n" "Deleting Network Interface ${eni_id}"
	aws ec2 delete-network-interface --region ${vpc_region} --no-dry-run --network-interface-id ${eni_id}
done

aws ec2 describe-security-groups --region ${vpc_region} --filters Name=vpc-id,Values="${vpc_id}" --query "SecurityGroups[*].[GroupId,GroupName]" --output text | while read sg_id sg_name
do
	if [ "${sg_name}" != "default" ]
	then
		printf "%s\n" "Deleting security group ${sg_name}"
		aws ec2 delete-security-group --region ${vpc_region} --no-dry-run --group-id ${sg_id}
	fi
done

aws ec2 describe-internet-gateways --region ${vpc_region} --filters Name=attachment.vpc-id,Values="${vpc_id}" --query "InternetGateways[*].[InternetGatewayId]" --output text | while read iw_id
do
	printf "%s\n" "Detaching Internet Gateway ${iw_id}"
	aws ec2 detach-internet-gateway --region ${vpc_region} --no-dry-run --internet-gateway-id ${iw_id} --vpc-id ${vpc_id}
	printf "%s\n" "Deleting Internet Gateway ${iw_id}"
	aws ec2 delete-internet-gateway --region ${vpc_region} --no-dry-run --internet-gateway-id ${iw_id}
done

aws ec2 describe-route-tables --region ${vpc_region} --filters Name=vpc-id,Values="${vpc_id}" --query "RouteTables[*].[RouteTableId]" --output text | while read rt_id
do
	if [ "${rt_id}" != "default" ]
	then
		printf "%s\n" "Deleting Route Table ${rt_id}"
		aws ec2 delete-route-table --region ${vpc_region} --no-dry-run --route-table-id ${rt_id}
	fi
done

aws ec2 describe-subnets --region ${vpc_region} --filters Name=vpc-id,Values="${vpc_id}" --query "Subnets[*].[SubnetId]" --output text | while read subnet_id
do
	printf "%s\n" "Deleting Subnet ${subnet_id}"
	aws ec2 delete-subnet --region ${vpc_region} --no-dry-run --subnet-id ${subnet_id}
done

printf "%s\n" "Finally deleting VPC ${vpc_id}"
aws ec2 delete-vpc --region ${vpc_region} --no-dry-run --vpc-id "${vpc_id}"
