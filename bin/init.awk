#!/bin/bash
gawk '{
repo=$1
depot=$2
cmd="git init "repo
system(cmd)
cmd2="p4where "depot
cmd2 |& getline $2
cmd3="git --git-dir="repo"/.git config core.worktree "$2
system(cmd3)
for(i = 3; i <= NF; i++) { cmd4="echo "$i" >> "repo"/.git/info/exclude"; system(cmd4) }
system("export GIT_DIR="repo"/.git ; p4init")
}'
