#!/bin/bash
mkdir repo
cd repo
git init .
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<manifest>
  <remote  name=\"p4git\"
           fetch=\".\" />

  <default revision=\"refs/heads/p4/master\"
           remote=\"p4git\"
           sync-j=\"4\" /> " > default.xml
cd ..

gawk -v p4b_home=$P4BRIDGE_HOME '{
repo=$1
depot=$2
projpath=$3
cmd4="echo \"<project name=\\\""repo"\\\" remote=\\\"p4git\\\" path=\\\""projpath"\\\"/>\" >> "p4b_home"/repo/default.xml"
system(cmd4)
cmd="git init "repo
system(cmd)
cmd2="p4b_where "depot"/..."
cmd2 |& getline $2
gsub(/\/\.\.\./, "", $2)
cmd3="git --git-dir="repo"/.git config core.worktree "$2
system(cmd3)
for(i = 4; i <= NF; i++) { cmd4="echo "$i" >> "repo"/.git/info/exclude"; system(cmd4) }
system("export GIT_DIR="repo"/.git ; p4b_helperinit "depot)
}'

cd repo
echo "</manifest>" >> default.xml
git add default.xml
git commit -m "repo init"
