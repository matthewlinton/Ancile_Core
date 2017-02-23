@REM Modify Tasks - Enable or disable tasks listed in a file using the Windows task scheduler
@REM USAGE : modify_tasks.cmd <ENABLE|DISABLE|DELETE> <File to Parse>
@REM This script relies on the Ancile shell variable:
@REM "DEBUG"
@REM "ANCERRLVL"
@REM "LOGFILE"

@REM Dependencies
IF NOT "%APPNAME%"=="Ancile" (
	ECHO ERROR: Modify Tasks is meant to be launched by Ancile, and will not run as a stand alone script.
	ECHO Press any key to exit ...
	PAUSE >nul 2>&1
	EXIT
)

IF NOT EXIST "%~2" (
	@REM make sure the file exists
	ECHO ERROR: File "%~2" could not be found. >> "%LOGFILE%" 2>&1
	SET /A ANCERRLVL=ANCERRLVL+1
) ELSE (
	@REM Disable tasks
	IF "%1"=="DISABLE" (
		FOR /F "eol=# tokens=*" %%i IN ('TYPE "%~2" 2^>^>1') DO (
			IF "%DEBUG%"=="Y" (
				ECHO Disabling: "%%i" >> "%LOGFILE%" 2>&1
				schtasks /query /tn "%%i" >nul 2>&1 && schtasks /change /disable /tn "%%i" >> "%LOGFILE%" 2>&1
			) ELSE (
				schtasks /query /tn "%%i" >nul 2>&1 && schtasks /change /disable /tn "%%i" >nul 2>&1
			)
		)
	)

	@REM Enable tasks
	IF "%1"=="ENABLE" (
		FOR /F "eol=# tokens=*" %%i IN ('TYPE "%~2" 2^>^>1') DO (
			IF "%DEBUG%"=="Y" (
				ECHO Enabling: "%%i" >> "%LOGFILE%" 2>&1
				schtasks /query /tn "%%i" >nul 2>&1 && schtasks /change /enable /tn "%%i" >> "%LOGFILE%" 2>&1
			) ELSE (
				schtasks /query /tn "%%i" >nul 2>&1 && schtasks /change /enable /tn "%%i" >nul 2>&1
			)
		)
	)

	@REM Delete tasks
	IF "%1"=="DELETE" (
		FOR /F "eol=# tokens=*" %%i IN ('TYPE "%~2" 2^>^>1') DO (
			IF "%DEBUG%"=="Y" (
				ECHO Deleting: "%%i" >> "%LOGFILE%" 2>&1
				schtasks /query /tn "%%i" >nul 2>&1 && schtasks /delete /tn "%%i" >> "%LOGFILE%" 2>&1
			) ELSE (
				schtasks /query /tn "%%i" >nul 2>&1 && schtasks /delete /tn "%%i" >nul 2>&1
			)
		)
	)
)
