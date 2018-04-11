#!/bin/bash
export aws_region="$1"
export rds_instance="$2"

export DATE=`date '+%Y%m%d.%H%M'`
if [ -z "$3" ]
then
	export snapshot_name="${rds_instance}-${DATE}"
else
	export snapshot_name=$3
fi

printf "%s\n" "Creating RDS Snapshot ${snapshot_name} for ${rds_instance} in region ${aws_region}"

aws rds create-db-snapshot --region "${aws_region}" --db-instance-identifier ${rds_instance} --db-snapshot-identifier ${snapshot_name}
