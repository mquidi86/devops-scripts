#!/bin/bash
export aws_region="$1"
shift
export volume_name="$*"

printf "%s\n" "Describing EC2 volumes for region ${aws_region} ${volume_name/#/for } " 

aws ec2 describe-volumes --region "${aws_region}" ${volume_name/#/--volume-ids } \
--output table \
--query 'sort_by(Volumes[],&CreateTime )[].[VolumeId,State,VolumeType,Size,Iops,CreateTime,AvailabilityZone,SnapshotId,Attachments[].State| [0],Attachments[].InstanceId| [0]]'
