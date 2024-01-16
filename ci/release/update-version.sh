#!/bin/bash
# Copyright (c) 2024, NVIDIA CORPORATION.

## Usage
# bash update-version.sh <new_version>


# Format is MAJOR.MINOR.PATCH - no leading 'v' or trailing 'a'
NEXT_FULL_TAG=$1

echo "Preparing release $CURRENT_TAG => $NEXT_FULL_TAG"

# Inplace sed replace; workaround for Linux and Mac
function sed_runner() {
    sed -i.bak ''"$1"'' $2 && rm -f ${2}.bak
}

# Centralized version file update
echo "${NEXT_FULL_TAG}" > pynvjitlink/VERSION
sed_runner 's/'"^  VERSION [0-9\.]*"'/'"  VERSION ${NEXT_FULL_TAG}"'/g' CMakeLists.txt
sed_runner 's/^version = "[0-9\.]*"/version = "'${NEXT_FULL_TAG}'"/g' pyproject.toml
