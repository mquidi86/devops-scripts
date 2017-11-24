#!/bin/bash
export aws_region="$1"
export ami_name="$2"

# get the day 10 days before today
START_DATE=`date -d "10 day ago" +%F `

printf "%s\n" "Listing AMIs for region ${aws_region}" 

aws iam list-server-certificates --region ${aws_region} --output table \
--query "sort_by(ServerCertificateMetadataList[],&UploadDate)[].[ServerCertificateId,ServerCertificateName,UploadDate,Expiration,Path]"
#--query "sort_by(ServerCertificateMetadataList[],&UploadDate)[].[ServerCertificateId,ServerCertificateName,UploadDate,Expiration,Path,Arn]"
