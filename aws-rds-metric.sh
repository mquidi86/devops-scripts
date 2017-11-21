
#aws cloudwatch get-metric-statistics --namespace AWS/RDS --metric-name DatabaseConnections --dimensions Name=DBInstanceIdentifier,Value=richardlogin --start-time 2017-03-01T00:00:00Z --end-time 2017-10-22T00:00:00Z --period 86400 --statistics Average
aws cloudwatch get-metric-statistics --namespace AWS/RDS --metric-name DatabaseConnections --dimensions Name=DBInstanceIdentifier,Value=logindev --start-time 2017-03-01T00:00:00Z --end-time 2017-10-22T00:00:00Z --period 86400 --statistics Average --query "Datapoints[*].[Timestamp,Average]" --output text | sort 
