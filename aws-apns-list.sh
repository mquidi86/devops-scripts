#!/bin/bash
export aws_region="$1"

printf "%s\n" "Listing APNs Certificates for region ${aws_region}" 

aws sns list-platform-applications --region ${aws_region} --output table \
--query "sort_by(PlatformApplications[?Attributes.AppleCertificateExpirationDate],&Attributes.AppleCertificateExpirationDate)[].[PlatformApplicationArn,Attributes.Enabled,Attributes.AppleCertificateExpirationDate]"
