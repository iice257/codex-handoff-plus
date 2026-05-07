@echo off
setlocal

set "NODE_EXE=%~1"
set "SCRIPT=%~2"
if "%SCRIPT%"=="" (
  set "SCRIPT=%~1"
  set "NODE_EXE="
)
if "%SCRIPT%"=="" (
  echo Missing publish-stop script path. 1>&2
  exit /b 2
)

set "NODE_OPTIONS_CURRENT=%NODE_OPTIONS%"
echo %NODE_OPTIONS_CURRENT% | findstr /C:"--use-system-ca" >nul
if errorlevel 1 (
  if "%NODE_OPTIONS%"=="" (
    set "NODE_OPTIONS=--use-system-ca"
  ) else (
    set "NODE_OPTIONS=%NODE_OPTIONS% --use-system-ca"
  )
)

if not "%NODE_EXE%"=="" (
  "%NODE_EXE%" "%SCRIPT%"
  exit /b %errorlevel%
)

node "%SCRIPT%"
exit /b %errorlevel%
