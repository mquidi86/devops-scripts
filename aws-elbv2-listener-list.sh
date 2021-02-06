#!/bin/bash
export aws_region="$1"

printf "%s\n" "Listing Load Balancer Listeners for region ${aws_region}" 

aws elbv2 describe-load-balancers --region "${aws_region}" \
--query "LoadBalancers[*].[LoadBalancerArn]" \
--output text | while read elb_arn
do
  printf "%s\n" "Listing listeners for load balancer ${elb_arn}"
  aws elbv2 describe-listeners --region "${aws_region}" \
  --output table \
  --load-balancer-arn "${elb_arn}" \
  --query "sort_by(Listeners[],&Port)[].[ListenerArn,Port,Protocol,SslPolicy]"
done
