#!/bin/bash
export rds_region="$1"
export rds_name="$2"

printf "%s\n" "Listing RDS instance ${rds_name}" 

aws rds describe-db-instances --region "${rds_region}" "${rds_name:+--db-instance-identifier}" ${rds_name} \
--query "DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus,DBSubnetGroup.VpcId,MasterUsername,DBName,DBInstanceClass,Engine,EngineVersion,LatestRestorableTime,InstanceCreateTime,Endpoint.Address]" --output table
