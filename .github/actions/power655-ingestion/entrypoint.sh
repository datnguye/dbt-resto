#!/bin/sh
set -e

# cd $*

echo "Downloading csv from MongoDB"
mongoexport --uri="${MONGODB_URI}" \
  --collection=data \
  --type=csv \
  --fields=box_date,box_id,box_name,box_result_numbers,box_results,created_at,updated_at \
  --out=/opt/vietlot_power655_data.csv

echo "Commiting ${GITHUB_SHA} to repository"
REPOSITORY="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git config --global --add safe.directory /opt
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

git init
git remote add origin $REPOSITORY
git checkout main
git fetch origin main
cp /opt/vietlot_power655_data.csv ./seeds/vietlot/power655
git add .
git commit -m "Update ${GITHUB_SHA}:vietlot_power655_data.csv to seeds folder"
git push
rm -fr .git
cd $GITHUB_WORKSPACE

echo "Successfully ingestion."