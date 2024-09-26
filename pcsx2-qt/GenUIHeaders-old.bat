@echo off

setlocal enabledelayedexpansion

set WorkingDir=%~dp0
set OutputDir="%WorkingDir%Generated"
set UIC="%WorkingDir%\..\deps\bin\uic.exe"
set MOC="%WorkingDir%\..\deps\bin\moc.exe"
set RCC="%WorkingDir%\..\deps\bin\rcc.exe"

:: Generate moc files
:: ----------------------------------------------------------------
:: iterate over current directory
for %%f in (*.h) do (
    echo Generating moc_%%~nf.cpp ...
    %MOC% "%%f" -o %OutputDir%\moc_%%~nf.cpp || exit /b 1
)

:: iterater over subdirectories
for /R /D %%i in (*) do (
	pushd %%i

    for %%f in (*.h) do (
        echo Generating moc_%%~nf.cpp ...
        %MOC% "%%f" -o %OutputDir%\moc_%%~nf.cpp || exit /b 1
    )

    popd %%i
)

:: Generate qrc files
:: ----------------------------------------------------------------
:: iterate over current directory
for %%f in (*.qrc) do (
    echo Generating qrc_%%~nf.cpp ...
    %RCC% "%%f" -o %OutputDir%\qrc_%%~nf.cpp || exit /b 1
)

:: iterater over subdirectories
for /R /D %%i in (*) do (
	pushd %%i

    for %%f in (*.qrc) do (
        echo Generating qrc_%%~nf.cpp ...
        %RCC% "%%f" -o %OutputDir%\qrc_%%~nf.cpp || exit /b 1
    )

    popd %%i
)

:: Generate ui header files
:: ----------------------------------------------------------------

:: iterate over current directory
for %%f in (*.ui) do (
    echo Generating ui_%%~nf.h ...
    %UIC% "%%f" -o %OutputDir%\ui_%%~nf.h || exit /b 1
)

:: iterater over subdirectories
for /R /D %%i in (*) do (
	pushd %%i

    for %%f in (*.ui) do (
        echo Generating ui_%%~nf.h ...
        %UIC% "%%i\%%f" -o %OutputDir%\ui_%%~nf.h || exit /b 1
    )

    popd %%i
)
