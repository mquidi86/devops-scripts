#!/bin/bash
export aws_region="$1"
export ami_name="$2"
export days_backwards="$2"

# get the day 20 days before today
START_DATE=`date -d "${days_backwards:-20} day ago" +%F `

printf "%s\n" "Listing AMIs for region ${aws_region} since ${START_DATE}" 

aws ec2 describe-images --region "${aws_region}" --output table \
--filters Name=is-public,Values=false \
--query "sort_by(Images[?CreationDate>=\`${START_DATE}\`],&CreationDate)[].[Name,ImageId,ImageType,CreationDate,State]"
