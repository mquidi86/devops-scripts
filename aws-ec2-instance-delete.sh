#!/bin/bash
export vpc_region="$1"
export vpc_id="$2"

aws ec2 describe-security-groups --region ${vpc_region} --filters Name=vpc-id,Values="${vpc_id}" --query "SecurityGroups[*].[GroupId,GroupName]" --output text | while read sg_id sg_name
do
	if [ "${sg_name}" != "default" ]
	then
		printf "%s\n" "Deleting security group ${sg_name}"
		aws ec2 delete-security-group --region ${vpc_region} --no-dry-run --group-id ${sg_id}
	fi
done

printf "%s\n" "Finally deleting VPC ${vpc_id}"
aws ec2 delete-vpc --region ${vpc_region} --no-dry-run --vpc-id "${vpc_id}"
#!/bin/bash
export aws_region="$1"
export asg_name="$2"

aws autoscaling describe-auto-scaling-groups --region "${aws_region}" ${asg_name:+--auto-scaling-group-names} ${asg_name} --output table \
	--query "AutoScalingGroups[*].Instances[*]"
