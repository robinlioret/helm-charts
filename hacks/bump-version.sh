#!/bin/sh
# hack/bump-version.sh
# Usage: ./hack/bump-version.sh <chart_dir> <new_version>
# Bumps chart versions in .version

set -e
set -x

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <charts_dir> <new_version>"
  exit 1
fi

CHARTS_DIR="$1"
NEW_VERSION="$2"

if [ -d "$CHARTS_DIR/$CHART_SUBDIR" ]; then
  cd "$CHARTS_DIR/$CHART_SUBDIR"
else
  echo "Directory not found: $CHARTS_DIR/$CHART_SUBDIR"
  exit 1
fi

# Replace all occurrences of vX.Y.Z with the new version (vNEW_VERSION)
sed -Ei "s/^version: [0-9]+\.[0-9]+\.[0-9]+(\-[a-zA-Z0-9\-\.]+)*/version: $NEW_VERSION/g" Chart.yaml

# Set the new version file
echo -n "$NEW_VERSION" > .version
echo "Bump chart version to $NEW_VERSION for chart $CHARTS_DIR/$CHART_SUBDIR"
