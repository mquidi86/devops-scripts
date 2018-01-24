#!/bin/bash
export aws_region="$1"
#export ami_name="$2"

printf "%s\n" "Listing SNS Subscriptions for region ${aws_region}" 

aws sns list-subscriptions --region "${aws_region}" --output table \
--query "Subscriptions[].[Endpoint,Protocol,SubscriptionArn,TopicArn]"
#--query "sort_by(Images[],&CreationDate)[].[Endpoint,Protocol,Subscriptions,CreationDate,State]"
