#!/usr/bin/env bash

cat git_repos | awk '{ print "cd " $1 "&& git checkout -p;\n" }'
