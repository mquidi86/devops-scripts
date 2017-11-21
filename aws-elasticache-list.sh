#!/bin/bash
export aws_region="$1"
#export vpc_id="$2"

printf "%s\n" "Listing Elasticache Clusters for region ${aws_region}" 

aws elasticache describe-cache-clusters --region "${aws_region}" \
--query "CacheClusters[*].[CacheClusterId,CacheClusterStatus,NumCacheNodes,CacheNodeType,CacheClusterCreateTime,PreferredAvailabilityZone,join(':',[ConfigurationEndpoint.Address||' ',to_string(ConfigurationEndpoint.Port||' ')])]" --output table
#--query "CacheClusters[*].[CacheClusterId,CacheClusterStatus,NumCacheNodes,CacheNodeType,CacheClusterCreateTime,PreferredAvailabilityZone]" --output table
