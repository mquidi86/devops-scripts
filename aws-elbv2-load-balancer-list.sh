#!/bin/bash
export aws_region="$1"

printf "%s\n" "Listing Load Balancers for region ${aws_region}" 

aws elbv2 describe-load-balancers --region "${aws_region}" \
--output table \
--query "sort_by(LoadBalancers[],&VpcId)[].[LoadBalancerName,VpcId,Scheme,CreatedTime]"
