@echo off
setlocal enabledelayedexpansion

if not exist Generated\Translations mkdir Generated\Translations

set WorkingDir=%~dp0
set OutputDir="%WorkingDir%Generated\Translations"
set LRelease=%WorkingDir%..\deps\bin\lrelease.exe

for %%f in (*.ts) do (
    echo Generating %%~nf.qm ...
    "%LRelease%" "%%f" -qm %OutputDir%\%%~nf.qm || exit /b 1
)

for /R /D %%i in (*) do (
    pushd %%i
    for %%f in (*ts) do (
        echo Generating %%~nf.qm ...
        "%LRelease%" "%%f" -qm %OutputDir%\%%~nf.qm || exit /b 1
    )
    popd %%i
)