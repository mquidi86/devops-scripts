#!/bin/bash
export aws_region="$1"
export db_source="$2"
export db_target="$3"
export db_snapshot="$4"

aws rds describe-db-instances --region "${aws_region}" --db-instance-identifier "${db_source}" \
--query "DBInstances[*].[DBInstanceStatus,DBInstanceClass,DBSubnetGroup.DBSubnetGroupName,AvailabilityZone,OptionGroupMemberships[0].OptionGroupName,PubliclyAccessible,MultiAZ]" --output text | while read db_Status db_class db_subnetgroup db_az db_option db_public_access db_multiaz
do
	if [ "${db_snapshot:-LATEST}" == "LATEST" ]
	then
		db_snapshot=`aws rds describe-db-snapshots --region "${aws_region}" --db-instance-identifier "${db_source}" --output text --query "sort_by(DBSnapshots,&SnapshotCreateTime)[].[DBSnapshotIdentifier]" | tail -1`
	fi

	test "${db_public_access}" == "True" && db_public_access="--publicly-accessible" || db_public_access="--no-publicly-accessible"
	test ${db_multiaz} == "True" && db_multiaz="--multi-az" || db_multiaz="--no-multi-az"

	aws rds restore-db-instance-from-db-snapshot --region "${aws_region}" --db-instance-identifier "${db_target}" --db-snapshot-identifier "${db_snapshot}" \
	--db-subnet-group-name "${db_subnetgroup}" --availability-zone "${db_az}" --option-group-name "${db_option}" "${db_public_access}" "${db_multiaz}"

	echo Modify the following after the DB is created
	db_vpc_sg=`aws rds describe-db-instances --region "${aws_region}" --db-instance-identifier "${db_source}" --query "DBInstances[*].[VpcSecurityGroups[*].[VpcSecurityGroupId]]" --output text`

	db_parameter_groups=`aws rds describe-db-instances --region "${aws_region}" --db-instance-identifier "${db_source}" --query "DBInstances[*].[DBParameterGroups[*].[DBParameterGroupName]]" --output text`
	
	echo aws rds modify-db-instance --region "${aws_region}" --db-instance-identifier "${db_target}" --vpc-security-group-ids "${db_vpc_sg[@]}" --db-parameter-group-name "${db_parameter_groups[@]}" --apply-immediately
done
