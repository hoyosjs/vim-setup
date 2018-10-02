#!/bin/bash

# Backup vimrc
cp ~/.vimrc .

# Backup extensions
EXTENSION_DIR_LIST=`ls -1 -d ~/.vim/bundle/*`
FILE_LIST_REPO="extension_list.ext"
[[ -f $FILE_LIST_REPO ]] && rm $FILE_LIST_REPO

for EXTENSION_DIR in $EXTENSION_DIR_LIST; do
    pushd $EXTENSION_DIR > /dev/null
    REPO_LINK=`git remote get-url origin`
    popd > /dev/null
    echo git clone $REPO_LINK >> $FILE_LIST_REPO
done

