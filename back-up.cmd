@if not defined _echo @echo off
setlocal enableDelayedExpansion

set EXTENSION_FILE="extension_list.ext"
set EXTENSION_DIR="%HOME%\vimfiles\bundle"

:: Backup vimrc
copy /Y "%HOME%\_vimrc" .vimrc

:: Backup extensions
if exist %EXTENSION_FILE% (
    del %EXTENSION_FILE%
)

for /d %%p in (%EXTENSION_DIR%\*) do (
    pushd %%p
    (git remote get-url origin) > temp.txt
    set /P REPO_LINK=<"temp.txt"
    del temp.txt
    popd
    echo git clone !REPO_LINK! >> %EXTENSION_FILE%
)
