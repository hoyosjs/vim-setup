@if not defined _echo @echo off
setlocal EnableDelayedExpansion EnableExtensions

set EXTENSIONS_FILE="extension_list.ext"
set EXT_DIR="%HOME%\vimfiles\bundle"
set AUTO_DIR="%HOME%\vimfiles\autoload"

:: TODO: Check vim availability.

:: Copy vimrc to home.
copy .vimrc "%HOME%\_vimrc"

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
for /F "tokens=*" %%LINE in ("%SCRIPT_DIR%\%EXTENSIONS_FILE%") do (
    echo %%LINE
)
popd
