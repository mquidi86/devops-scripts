#!/bin/bash
export aws_region="$1"
export days_backwards="$2"

# get the day 10 days before today
START_DATE=`date -d "${days_backwards:-10} day ago" +%F `

printf "%s\n" "Listing Snapshots for EC2 Instances for region ${aws_region} older than ${START_DATE}" 

aws ec2 describe-snapshots --region "${aws_region}" --output table \
--owner-ids self \
--query "sort_by(Snapshots[?StartTime<=\`${START_DATE}\`],&StartTime)[].[VolumeId,SnapshotId,StartTime,VolumeSize,Encrypted,State,OwnerId,Description]"
