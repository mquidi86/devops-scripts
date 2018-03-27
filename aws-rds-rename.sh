#!/bin/bash
export aws_region="$1"
export source_name="$2"
export target_name="$3"

printf "%s\n" "Changing RDS instance name from ${source_name} to ${target_name}" 

aws rds modify-db-instance --region "${aws_region}" --db-instance-identifier "${source_name}"  --new-db-instance-identifier ${target_name} --apply-immediately
