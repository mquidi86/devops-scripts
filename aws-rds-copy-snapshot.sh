#!/bin/bash
export source_region="$1"
export source_snapshot="$2"
export target_region="$3"
export target_snapshot="$4"

printf "%s\n" "Copying RDS Snapshot" 

aws rds copy-db-snapshot --region "${target_region}" --source-region "${target_region}" --source-db-snapshot-identifier ${source_snapshot} --target-db-snapshot-identifier ${target_snapshot}
