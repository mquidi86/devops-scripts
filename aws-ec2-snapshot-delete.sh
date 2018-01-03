#!/bin/bash
export aws_region="$1"
export days_backwards="$2"

# Get start_date from the environment if days_backwards not set
test -n "${START_DATE}" || START_DATE=`date -d "${days_backwards:-60} day ago" +%F `
# delete snapshots older than 60 days by default
test -n "${days_backwards}" && START_DATE=`date -d "${days_backwards:-60} day ago" +%F `

printf "%s\n" "Deleting EBS Snapshots for region ${aws_region} older than ${START_DATE}" 
printf "%s" "Please confirm [y/n]: " 

read confirmation
if [ "${confirmation}" != "y" ]
then
	exit 1
fi

aws ec2 describe-snapshots --region "${aws_region}" --output text \
--owner-ids self \
--query "sort_by(Snapshots[?StartTime<\`${START_DATE}\`],&StartTime)[].[VolumeId,SnapshotId,StartTime]" | while read snap_volume_id snap_id snap_time 
do
	printf "%s" "Deleting Snapshot ${snap_id} of volume ${snap_volume_id}, date ${snap_time}... " 
	aws ec2 delete-snapshot --region "${aws_region}" --snapshot-id "${snap_id}" && printf "OK.\n" || printf "Failed.\n" 
done
