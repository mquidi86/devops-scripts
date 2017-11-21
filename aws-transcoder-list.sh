#!/bin/bash
export transc_region="$1"

printf "%s\n" "Listing Elastic Transcoder instance ${transc_name}" 

aws elastictranscoder list-pipelines --region "${transc_region}" --query "Pipelines[*].[Name,Id,Status,InputBucket,OutputBucket,Notifications.Error]" --output table
