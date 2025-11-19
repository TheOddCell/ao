#!/bin/sh

if [ -z "$GITHUB_TOKEN" ]; then
  echo 'please set $GITHUB_TOKEN thx'
  exit 1
fi
curl -L -H "Authorization: token $GITHUB_TOKEN" "$(curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/TheOddCell/ao/actions/runs?per_page=1" \
| jq -r '.workflow_runs[0].id' \
| xargs -I {} curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/TheOddCell/ao/actions/runs/{}/artifacts" \
| jq -r '.artifacts[0].archive_download_url')" \
| funzip \
| tar -xz
