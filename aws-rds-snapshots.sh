#!/bin/bash
export rds_region="$1"
export rds_name="$2"

printf "%s\n" "Listing RDS Snapshots ${rds_name:+for} ${rds_name}" 

aws rds describe-db-snapshots --region "${rds_region}" "${rds_name:+--db-instance-identifier}" ${rds_name} \
--query "DBSnapshots[*].[DBSnapshotIdentifier,Status,SnapshotCreateTime,PercentProgress,SnapshotType,StorageType,DBInstanceIdentifier,VpcId]" --output table
