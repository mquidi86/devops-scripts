#!/bin/bash
REGIONS_FILE=`dirname $0`/aws-regions.lst
stack_name=$1
debug=$2
test "${debug}" == "on" && printf "%s\n" "Listing CloudFormation Stacks for all regions" 

log() {
        LOG_CATEGORY=$1

        if [ "$$" == "$BASHPID" ];then
                PID="$$     "
        else
                PID="$$:${BASHPID}"
        fi
        shift
        PRINT_FIRST_ARG=$1
        shift
        test "${debug}" == "on" && printf "`date '+%Y-%b-%d %T'`|%6s|%12s|%20s |\t${PRINT_FIRST_ARG}\n" ${LOG_CATEGORY} ${PID} ${MODULE_NAME} "$@"
}


checkStackRegion() {
        local MODULE_NAME="checkStackRegion"
        local Stack_name=$1
        local check_region=$2
        aws cloudformation describe-stacks --output text --region "${check_region}" --stack-name ${Stack_name} --query 'Stacks[].StackName' 2>/dev/null >&2
        aws_rc=$?

        test ${aws_rc} -eq 0 && log DEBUG "Stack found in region: ${check_region}" || log DEBUG "Stack not found in region: ${check_region}"
        return ${aws_rc}
}

findStack() {
        local MODULE_NAME="findStack"
        local Stack_name=$1
        #aws_region_list="us-east-1 us-east-2 us-west-1 us-west-2 ca-central-1 eu-west-1 eu-west-2 eu-west-3 eu-central-1 ap-southeast-1 ap-southeast-2 ap-northeast-1 ap-northeast-2 ap-south-1 sa-east-1"

        log INFO "Looking for ${Stack_name} stack in every AWS region."
        for region_try in `cat ${REGIONS_FILE} | cut -f1 -d'|'`
        do
                checkStackRegion ${Stack_name} ${region_try} &
                pid_list="${pid_list}${!}:${region_try} "
        done

        declare -i region_count=0
        for pid_and_reg in `echo ${pid_list}`
        do
                pid=`echo ${pid_and_reg} | cut -f1 -d":"`
                pid_region=`echo ${pid_and_reg} | cut -f2 -d":"`

                wait ${pid} ; pid_rc=$?

                if [ "${pid_rc}" -eq 0 ]
                then
                        test ${region_count} -gt 0 && log ERROR "Stack appears in more than 1 region: ${aws_Region} && ${pid_region}" && return 1
                        (( ++region_count ))
                        log INFO "Stack region is ${pid_region}"
                        region="${pid_region}"
                fi

        done
}

## Main

findStack ${stack_name}
echo $region
