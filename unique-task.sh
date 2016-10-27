#!/bin/bash

# Purpose: Creates a task warrior task, but only if a task with that
# description does not already exist.
# Requires: jq https://stedolan.github.io/jq/
# Caveats: Tasks must be created with a project (see Example).
# Example: unique-task.sh take me to the store project:errands

set -e

task status:pending export | jq -r '.[].description' | while read p; do
description=$(echo "$*" |awk 'BEGIN { FS = "project" } ; { print $1 }')
    if [ "$description" = "$p " ]; then
        echo "Task is already pending. Skipping."
        exit 1
    fi

done < /dev/stdin

# Unquoted expansion required so that task warrior arguments are passed
# through.
task add $*
