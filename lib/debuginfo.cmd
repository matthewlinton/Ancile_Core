@ECHO off
@REM debuginfo - generate a log file with debug info about the user's default system.

SETLOCAL

@REM Configure the default environment
SET _appname=Ancile_debuginfo
SET _version=1.1

:CONFIG
@REM Generate universal non locale specific date
FOR /F "usebackq tokens=1,2 delims==" %%i IN (`wmic os get LocalDateTime /VALUE 2^>NUL`) DO (
	IF '.%%i.'=='.LocalDateTime.' SET ldt=%%j
)
SET _unidate=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2%

@REM configure script variables
SET _currdir=%~dp0
SET _logfile=%_currdir%%_appname%.%_unidate%.log

:BEGIN
ECHO %_appname% v%_version%
ECHO.

@REM Begin Logging
ECHO [%DATE% %TIME%] ### %_appname% v%_version% ################################# > "%_logfile%"
ECHO [%DATE% %TIME%] Created by Matthew Linton >> "%_logfile%"
ECHO [%DATE% %TIME%] https://bitbucket.org/ancile_development/ >> "%_logfile%"
ECHO [%DATE% %TIME%] ############################################################ >> "%_logfile%"

@REM Get command
ECHO %0 >> "%_logfile%"

@REM OS Version
ver >> "%_logfile%"

@REM Net Connected
SET _netconnected=Unable to ping bitbucket.org
ping -n 1 bitbucket.org >nul 2>&1 && SET _netconnected=Network Connected
ECHO %_netconnected% >> "%_logfile%"

@REM Make sure we're running as an administrator
@REM Better admin check thanks to bl0ck0ut (https://voat.co/v/Ancile/1843979)
@REM Check if user is part of the local admin group
SET admin=N
SET domain=%USERDOMAIN%\
IF /i "%domain%"=="%COMPUTERNAME%\" SET domain=
SET user=%domain%%USERNAME%
FOR /f "Tokens=*" %%a IN ('net localgroup administrators^| find /i "%user%"') DO ( SET admin=Y )
@REM Check for administrative rights by trying to set the archive attribute on the hosts file
SET priv=Y
FOR /f "Tokens=*" %%a IN ('attrib +A %SYSTEMROOT%\System32\drivers\etc\hosts^| find /i "Access denied"') DO ( SET priv=N )
@REM Are we an Administrator? 
IF "%priv%"=="Y" ( 
	ECHO Running as an Administrator >> "%_logfile%"
) ELSE (
	ECHO Not running as an Administrator >> "%_logfile%"
)

@REM Get environment
ECHO Gathering environment information ...
ECHO [%DATE% %TIME%] BEGIN ENVIRONMENT ############################################################ >> "%_logfile%"

SET >> "%_logfile%"

ECHO [%DATE% %TIME%] END ENVIRONMENT ############################################################ >> "%_logfile%"
ECHO. >> "%_logfile%"

@REM Gather user information
ECHO Fetching user information ...
ECHO [%DATE% %TIME%] BEGIN USER ############################################################ >> "%_logfile%"

whoami /GROUPS >> "%_logfile%" 2>&1

ECHO [%DATE% %TIME%] END USER ############################################################ >> "%_logfile%"
ECHO. >> "%_logfile%"

@REM Gather system information
ECHO Fetching system information ...
ECHO [%DATE% %TIME%] BEGIN SYSTEM ############################################################ >> "%_logfile%"

systeminfo >> "%_logfile%"

ECHO [%DATE% %TIME%] END SYSTEM ############################################################ >> "%_logfile%"
ECHO. >> "%_logfile%"

@REM Check powershell environment
ECHO Fetching Powershell Environment ...
ECHO [%DATE% %TIME%] BEGIN POWERSHELL ############################################################ >> "%_logfile%"

powershell -executionpolicy remotesigned -Command $PSVersionTable >> "%_logfile%"

ECHO Execution Policy: >> "%_logfile%"
powershell -executionpolicy remotesigned -Command get-executionpolicy >> "%_logfile%"

ECHO [%DATE% %TIME%] END POWERSHELL ############################################################ >> "%_logfile%"
ECHO. >> "%_logfile%"

:FINISH
ECHO.
ECHO Your system information can be found in the file:
ECHO "%_logfile%"
ECHO.
ECHO CAUTION: This file contains a lot of information on your system configuration.
ECHO Please take time to review the log file and remove any information that you
ECHO wouldn't want to be made public. Replace values with XXXXXXXXXXXXXXXXXXXXX
ECHO to maintain formatting
ECHO.
ECHO. >> "%_logfile%"
ECHO. >> "%_logfile%"

:END
PAUSE



ENDLOCAL