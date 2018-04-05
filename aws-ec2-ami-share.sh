#!/bin/bash
export aws_region="$1"
shift
export ami_id="$1"
shift
export target_accounts="$@"

ami_name=`aws ec2 describe-images --region "${aws_region}" --image-id "${ami_id}" --output text \
--query "Images[].[Name]"`

printf "%s\n" "Sharing AMI ${ami_id} ${ami_name} at ${aws_region} to accounts ${target_accounts}"

for aws_account in $target_accounts
do
	aws ec2 modify-image-attribute --region "${aws_region}" --image-id "${ami_id}" --launch-permission "{\"Add\": [{\"UserId\":\"${aws_account}\"}]}"
done
