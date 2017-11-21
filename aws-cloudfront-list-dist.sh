#!/bin/bash
export aws_region="$1"
export distribution_name="$2"

printf "%s\n" "Listing CloudFront distributions for region ${aws_region}" 

aws cloudfront list-distributions --region "${aws_region}" \
--output table \
--query 'DistributionList.Items[*].[ARN,Id,DomainName,Origins.Items[*].Id | [0],Status]'
#--query 'DistributionList.Items[*].[ARN,DomainName,DefaultCacheBehavior.Origins.Items[*].Id]'
#--query 'DistributionList[*].Items[*].[ARN,DomainName,DefaultCacheBehavior.OriginId]'
