#!/bin/bash
export rds_region="$1"
export rds_name="$2"

printf "%s\n" "Deleting RDS instance ${rds_name}" 

aws rds delete-db-instance --region "${rds_region}" --db-instance-identifier "${rds_name}" --no-skip-final-snapshot --final-db-snapshot-identifier "${rds_name}-final-snapshot"

