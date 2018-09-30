#!/bin/bash
EXTENSIONS_FILE="extension_list"
EXT_DIR="$HOME/.vim/bundle"
AUTO_DIR="$HOME/.vim/autoload"

command -v vim > /dev/null 2>&1 || { echo >&2 "VIM Required but not in path. Aborting."; exit 1; }

# Get vim pathogen
mkdir -p $AUTO_DIR && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install extensions
[[ -f $EXTENSIONS_FILE ]] || { echo >&2 "WARNING: No extensions to install."; exit 0; }

[[ -d $EXT_DIR ]] || mkdir -p $EXT_DIR

SCRIPT_DIR=$PWD
pushd $EXT_DIR >>/dev/null

while read line; do
    `$line >> /dev/null 2>&1` || echo "Failed to get extension provided by $line. Check connectivity, repo, and previous installation." 
done < $SCRIPT_DIR/$EXTENSIONS_FILE

popd >> /dev/null
