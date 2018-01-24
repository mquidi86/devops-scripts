#!/bin/bash
export aws_region="$1"
shift
export instance_name="$*"

printf "%s\n" "Describing EC2 instances for region ${aws_region} ${instance_name/#/for }" 

aws ec2 describe-instances --region "${aws_region}" ${instance_name/#/--instance-ids } \
--output table \
--query 'sort_by(Reservations[].Instances[],&LaunchTime )[].[Tags[?Key==`Name`].Value|[0],InstanceId,State.Name,ImageId,InstanceType,LaunchTime,PublicIpAddress,PrivateIpAddress,VpcId]'
