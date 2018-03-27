#!/bin/bash
export aws_region="$1"
export ami_id="$2"
export target_region="$3"

ami_name=`aws ec2 describe-images --region "${aws_region}" --image-id "${ami_id}" --output text \
--query "Images[].[Name]"`

printf "%s\n" "Copying AMI ${ami_id} ${ami_name} at ${aws_region} to region ${target_region}"

test ! -z "${ami_name}" && aws ec2 copy-image --region "${target_region}" --source-region "${aws_region}" --source-image-id "${ami_id}" --name "${ami_name}" || echo "AMI name empty"
