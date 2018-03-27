#!/bin/bash
export aws_region="$1"
export rds_name="$2"

printf "%s\n" "Listing RDS Snapshots ${rds_name:+for} ${rds_name}" 

aws rds describe-db-snapshots --region "${aws_region}" "${rds_name:+--db-instance-identifier}" ${rds_name} \
--query "sort_by(DBSnapshots,&SnapshotCreateTime)[].[DBSnapshotIdentifier,Status,SnapshotCreateTime,PercentProgress,SnapshotType,StorageType,DBInstanceIdentifier,VpcId,DBSnapshotArn]" --output table
