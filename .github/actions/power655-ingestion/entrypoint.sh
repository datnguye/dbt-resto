#!/bin/sh
set -e

echo "Install MongoDB Tools"
echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories
apk update
apk add mongodb-tools

echo "Check SKIP CI"
SKIP_CI="[Ingestion+]"
if [ $INGESTION_ONLY -eq 1 ]
then
  SKIP_CI="[skip ci]"
fi

echo "Downloading csv from MongoDB"
mongoexport --uri="${MONGODB_URI}" --collection=data --type=csv --fields=box_date,box_id,box_name,box_result_numbers,box_results,created_at,updated_at --out=/opt/vietlot_power655_data.csv

echo "Commiting ${GITHUB_SHA} to repository"
REPOSITORY="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git config --global --add safe.directory $GITHUB_WORKSPACE

git init
git remote add origin $REPOSITORY
git checkout main
git fetch origin main
cp /opt/vietlot_power655_data.csv ./seeds/vietlot/power655
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add .
git commit -m "Update ${GITHUB_SHA}:vietlot_power655_data.csv in seeds folder ${SKIP_CI}"
git push
rm -fr .git
cd $GITHUB_WORKSPACE

echo "Successfully ingestion."