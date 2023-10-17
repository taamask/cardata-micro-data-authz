export AWS_DEFAULT_PROFILE=tamskiss-dev

PIPELINE_VERSION=${1:-latest}

echo "Found Pipeline version $PIPELINE_VERSION, please explicitly specify a version number if a version other than $PIPELINE_VERSION is required eg ./update.sh 1.2.0"

PIPELINE_SRC_CODE=s3://cardata-pipeline-versioned-scripts/micro/$PIPELINE_VERSION

# If statement to check if version number exists
state=`aws s3 ls --profile $AWS_DEFAULT_PROFILE $PIPELINE_SRC_CODE`
if [[ -z $state ]]; then
  echo "Pipeline version does not exist, please try with the correct version number. Syncing latest release"
  # Syncing latest release
  aws --profile tamaskiss-dev s3 sync $PIPELINE_SRC_CODE . \
  --include "*.sh" \
  --include "*.yml" \
  --exclude "servicename" \
  --exclude "platform"
  chmod 755 *.sh
else
  echo "Pipeline version exists, moving to next step to sync files from AWS S3 bucket"
fi
# Syncing versioned release
aws --profile tamaskiss-dev s3 sync $PIPELINE_SRC_CODE . \
--include "*.sh" \
--include "*.yml" \
--exclude "servicename" \
--exclude "platform"
chmod 755 *.sh

unset AWS_DEFAULT_PROFILE