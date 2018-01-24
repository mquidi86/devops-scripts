#!/bin/bash
export aws_region="$1"
export days_backwards="$2"

# Get start_date from the environment if days_backwards not set
test -n "${START_DATE}" || START_DATE=`date -d "${days_backwards:-60} day ago" +%F `
# delete snapshots older than 60 days by default
test -n "${days_backwards}" && START_DATE=`date -d "${days_backwards:-60} day ago" +%F `

printf "%s\n" "Unregistering AMIs for region ${aws_region} older than ${START_DATE}"
printf "%s" "Please confirm [y/n]: "

read confirmation
if [ "${confirmation}" != "y" ]
then
        exit 1
fi

aws ec2 describe-images --region "${aws_region}" --output text \
--owners self \
--query "sort_by(Images[?CreationDate<\`${START_DATE}\`],&CreationDate)[].[ImageId,CreationDate]" | while read ami_id ami_created
do
        printf "%s" "Unregistering AMI ${ami_id} ,date ${ami_created}... "
        aws ec2 deregister-image --region "${aws_region}" --image-id "${ami_id}" && printf "OK.\n" || printf "Failed.\n"
done
