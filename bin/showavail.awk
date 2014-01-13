#!/bin/bash
gawk '{
repo=$1
depot=$2
system("export GIT_DIR="repo"/.git ; p4showavail "depot"/...")
}'
