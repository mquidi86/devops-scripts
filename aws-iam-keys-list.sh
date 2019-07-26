#!/bin/bash
key_content="${1}"

printf "%s\n" "Listing Accesss keys${key_content:+ that contain }${key_content:-}" 

for user in `aws iam list-users --output text --query 'Users[*].[UserName]'`
do
  if [ -n "${key_content}" ]
  then
    aws iam list-access-keys --user-name ${user} --output table --query "AccessKeyMetadata[?contains(AccessKeyId,\`${key_content}\`)]"
  else
    aws iam list-access-keys --user-name ${user}
  fi
done

