#!/bin/bash
export aws_region="$1"
export vpc_id="$2"

printf "%s\n" "Listing EC2 Security Groups for region ${aws_region} ${vpc_id:+for VPC }${vpc_id:-}" 

aws ec2 describe-security-groups --region ${aws_region} ${vpc_id:+--filters Name=vpc-id,Values=}${vpc_id:-} --output table \
--query "sort_by(SecurityGroups[],&not_null(VpcId,to_string(\`test\`)))[].[GroupName,VpcId,GroupId,Description]"
