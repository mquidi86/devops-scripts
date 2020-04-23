#!/bin/bash
export aws_region="$1"

printf "Getting the list of repositories in ${aws_region} \n"

aws ecr describe-repositories --region ${aws_region} \
 --output table \
 --query 'repositories[].[repositoryName,repositoryUri]'

