#!/bin/bash
export aws_region="$1"

printf "%s\n" "Listing Load Balancers for region ${aws_region}" 

aws elb describe-load-balancers --region "${aws_region}" \
--output table \
--query "sort_by(LoadBalancerDescriptions[],&VPCId)[].[LoadBalancerName,VPCId,Instances.InstanceId,Scheme,CreatedTime]"
