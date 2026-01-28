#!/bin/zsh
# Script to clone repositories from my personal github account
# 
# USAGE:
# ./clone.sh DIRNAME SSH-GITHUB-URL
# 
# EXAMPLE:
# ./clone.sh some-repo git@github.com:atornblad/some-repo.git

mkdir "$1"
cd "$1"
git init

git config --local core.sshcommand 'ssh -i ~/.ssh/id_kpulse -F /dev/null'
git config --local user.name 'Sergio Barrera'
git config --local user.email 'sergio@karmapulse.com'
git config --local push.autosetupremotes true
git remote add origin "$2"
git pull origin main
git branch -m main
