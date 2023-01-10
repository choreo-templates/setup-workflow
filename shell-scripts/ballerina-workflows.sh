# #!/bin/sh

export REG_CRED_FILE_NAME=registry-credentials.json
echo "REG_CRED_FILE_NAME=registry-credentials.json" >> $GITHUB_ENV
echo $1 > temp-env.json
echo $2 > temp-updated-env.json
jq .CONTAINER_REGISTRY_CRED_LIST temp-env.json > $REG_CRED_FILE_NAME
if [ "$(jq .CONTAINER_REGISTRY_CRED_LIST temp-updated-env.json)" ]; then
    jq .CONTAINER_REGISTRY_CRED_LIST temp-updated-env.json > $REG_CRED_FILE_NAME
fi
echo $| jq 'del(.CONTAINER_REGISTRY_CRED_LIST)' temp-env.json > env.json
echo $| jq 'del(.CONTAINER_REGISTRY_CRED_LIST)' temp-updated-env.json > updated-env.json
echo $| jq -r 'to_entries[] | [.key,(.value|@sh)] | join("=")' env.json > secrets.env
echo $| jq -r 'to_entries[] | [.key,(.value|@sh)] | join("=")' updated-env.json > updated-secrets.env
sort -u -t '=' -k 1,1 updated-secrets.env secrets.env | grep -v '^$|^s*#' > merged-secrets.env
ls -al
source merged-secrets.env

echo "APP_GH_TOKEN=$APP_GH_TOKEN" >> $GITHUB_ENV
echo "RUDDER_WEBHOOK_URL=$RUDDER_WEBHOOK_URL" >> $GITHUB_ENV
echo "RUDDER_WEBHOOK_SECRET=$RUDDER_WEBHOOK_SECRET" >> $GITHUB_ENV
echo "CHOREO_ORG_ID=$CHOREO_ORG_ID" >> $GITHUB_ENV
echo "CHOREO_PROJECT_ID=$CHOREO_PROJECT_ID" >> $GITHUB_ENV
echo "ENV_ID=$ENV_ID" >> $GITHUB_ENV
echo "APP_ID=$APP_ID" >> $GITHUB_ENV
echo "COMMIT_USER=$COMMIT_USER" >> $GITHUB_ENV
echo "COMMIT_EMAIL=$COMMIT_EMAIL" >> $GITHUB_ENV

echo "::add-mask::$RUDDER_WEBHOOK_URL"
echo "::add-mask::$RUDDER_WEBHOOK_SECRET"
echo "::add-mask::$CHOREO_ORG_ID"
echo "::add-mask::$CHOREO_PROJECT_ID"
echo "::add-mask::$ENV_ID"
echo "::add-mask::$APP_ID"

rm -rf env.json .env temp-env.json temp-updated-env.json updated-env.json secrets.env updated-secrets.env merged-secrets.env
cp  $REG_CRED_FILE_NAME /home/runner/workspace/$CHOREO_GITOPS_REPO
