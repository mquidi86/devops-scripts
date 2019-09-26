#!/bin/bash
export aws_region="$1"
export log_group_name="$2"
export log_stream_name="$3"

printf "%s\n" "Listing Log Events for ${log_group_name} for region ${aws_region}" 

aws logs get-log-events --region "${aws_region}" \
  --log-group-name "${log_group_name}" \
  --log-stream-name "${log_stream_name}" \
  --query "sort_by(events,&timestamp)[].[message]" \
  --output text
