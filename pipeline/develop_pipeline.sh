#!/bin/bash

set -e

# Checking for dependencies eg. jq
if [ -z $(which jq) ]; then echo "JQ not installed" && break; else echo "All dependencies met, deploying"; fi

SERVICE_NAME=`cat pipeline_config.json | jq -r '.commonConfig.serviceName'`
PLATFORM=`cat pipeline_config.json | jq -r '.commonConfig.platform'`

export AWS_DEFAULT_PROFILE=default #Change this

ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`

#Add role here
aws \
cloudformation \
deploy \
--template-file repository.yml \
--stack-name ${PLATFORM}-${SERVICE_NAME}-repository \
--no-fail-on-empty-changeset \
--parameter-overrides \
ServiceName=${SERVICE_NAME} \
PromoteAccount="UatAccount"

#Add role here
aws \
cloudformation \
deploy \
--template-file develop_pipeline.yml \
--stack-name ${PLATFORM}-${SERVICE_NAME}-develop-pipeline \
--no-fail-on-empty-changeset \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides \
ServiceName=${SERVICE_NAME} \
GithubRepo=${PLATFORM}-${SERVICE_NAME} \
GithubToken=`aws ssm get-parameter --name GithubToken --with-decryption --query "Parameter.Value" --output text` \
CyclingSecret=`openssl rand -base64 32`

unset AWS_DEFAULT_PROFILE