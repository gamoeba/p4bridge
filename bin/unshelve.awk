#!/bin/bash
gawk -v cl=$1 '{
repo=$1
depot=$2
system("export GIT_DIR="repo"/.git ; p4unshelve "cl)
}'
