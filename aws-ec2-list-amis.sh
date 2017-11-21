#!/bin/bash
export aws_region="$1"
export ami_name="$2"

# get the day 10 days before today
START_DATE=`date -d "10 day ago" +%F `

printf "%s\n" "Listing AMIs for region ${aws_region}" 

aws ec2 describe-images --region "${aws_region}" --output table \
--filters Name=is-public,Values=false \
--query "sort_by(Images[?CreationDate>=\`${START_DATE}\`],&CreationDate)[].[Name,ImageId,ImageType,CreationDate,State]"
