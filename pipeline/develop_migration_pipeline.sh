#!/bin/bash

set -e

# Checking for dependencies eg. jq
if [ -z $(which jq) ]; then echo "JQ not installed" && break; else echo "All dependencies met, deploying"; fi

SERVICE_NAME=`cat pipeline_config.json | jq -r '.commonConfig.serviceName'`
PLATFORM=`cat pipeline_config.json | jq -r '.commonConfig.platform'`

export AWS_DEFAULT_PROFILE=default

ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`

aws \
cloudformation \
deploy \
--template-file develop_migration_pipeline.yml \
--stack-name ${PLATFORM}-${SERVICE_NAME}-develop-migration-pipeline \
--no-fail-on-empty-changeset \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides \
ServiceName=${SERVICE_NAME} \
GithubRepo=${PLATFORM}-${SERVICE_NAME} \
CyclingSecret=`openssl rand -base64 32`

unset AWS_DEFAULT_PROFILE