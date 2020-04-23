#!/bin/bash
export aws_region="$1"
export registry_ids="$2"
export include_email="$3"

echo ">>$include_email<<"

printf "Getting login credentials to ${aws_region} \n"

if [[ -z "${include_email}" ]]; then
	export email='--no-include-email'
else
	export email='--include-email '
fi

if [[ -z "${registry_ids}" ]]; then
	export ids=''
else
	export ids="--registry-ids ${registry_ids}"
fi

echo "Email: $email"
echo "Regristry ids: ${ids}"

command="aws ecr get-login --region ${aws_region} ${email} ${ids}"
echo $command
eval $command