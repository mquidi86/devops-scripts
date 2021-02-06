#!/bin/bash
export aws_region="$1"
export log_group_name="$2"

export SCRIPTDIR=`dirname $0`

#printf "%s\n" "Listing CloudWatch Log Streams for group ${log_group_name} for region ${aws_region}" 

aws logs describe-log-streams --region "${aws_region}" \
  --log-group-name "${log_group_name}" \
  --query "sort_by(logStreams,&creationTime)[].[logStreamName,firstEventTimestamp,lastEventTimestamp,lastIngestionTime]" \
  --output json \
  | ${SCRIPTDIR}/python/print-times.py 1,2,3
