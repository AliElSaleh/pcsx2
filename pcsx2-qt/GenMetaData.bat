@echo off
setlocal enabledelayedexpansion

if not exist Generatedmkdir Generated

set WorkingDir=%~dp0
set OutputDir="%WorkingDir%Generated"
set UIC="%WorkingDir%..\deps\bin\uic.exe"
set MOC="%WorkingDir%..\deps\bin\moc.exe"
set RCC="%WorkingDir%..\deps\bin\rcc.exe"

call :Generate .h %MOC% moc_ .cpp -o
call :Generate .qrc %RCC% qrc_ .cpp -o
call :Generate .ui %UIC% ui_ .h -o
exit /b %ERRORLEVEL%

:: Function to generate files
:: Params:
:: %1 - File extension (e.g., .h, .qrc, .ui)
:: %2 - Tool/Compiler to use
:: %3 - Output file prefix (e.g., moc_, qrc_, ui_)
:: %4 - Output file extension (e.g., .cpp, .h)
:Generate
for %%f in (*%~1) do (
    echo Generating %~3_%%~nf%~4 ...
    "%~2" "%%f" %~5 %OutputDir%\%~3%%~nf%~4 || exit /b 1
)

for /R /D %%i in (*) do (
    pushd %%i
    for %%f in (*%~1) do (
        echo Generating %~3%%~nf%~4 ...
        "%~2" "%%f" %~5 %OutputDir%\%~3%%~nf%~4 || exit /b 1
    )
    popd %%i
)
exit /b 0