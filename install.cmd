@if not defined _echo @echo off
setlocal EnableExtensions EnableDelayedExpansion

set EXTENSIONS_FILE=extension_list.ext
set "EXT_DIR=%USERPROFILE%\vimfiles\bundle"
set "AUTO_DIR=%USERPROFILE%\vimfiles\autoload"

:: TODO: Check vim availability.

:: Copy vimrc to USERPROFILE.
copy .vimrc "%USERPROFILE%\_vimrc"

:: Get vim pathogen
md "%AUTO_DIR%" "%EXT_DIR%" 2> nul
IF NOT EXIST "%AUTO_DIR%\pathogen.vim" (
    curl -LSso "%AUTO_DIR%\pathogen.vim" https://tpo.pe/pathogen.vim
)

:: Install extensions
IF NOT EXIST "%EXTENSIONS_FILE%" (
    echo WARNING: No extensions to install
    exit /b 0
)

set SCRIPT_DIR=%~dp0
pushd %EXT_DIR%
for /f "tokens=*" %%a in (%SCRIPT_DIR%%EXTENSIONS_FILE%) do (
    call %%a 2> null || echo Failed to get extension provided by %%a. Check connectivity, repo, and previous installation.
)
popd
