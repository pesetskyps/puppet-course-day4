@echo off
rem Server:fApp01 FileMask:Emergency path:c:\Flux\Logs\Services\RtxService
cd %~dp0
set server=%1
set filemask=%2
set path1=%3
set warn=%4
set crit=%5

Call :CalcFileName %path1%

if not exist %logname%.sav (echo 0 > %logname%.sav)
For /F %%a in (%logname%.sav) Do Call :Calc %%a
goto :eof

:Calc
set prevSize=%1

set fullpath=%path1:~5%\%filemask:~9%*

rem check existence of emergency logs in folder c:\Flux\Logs\Services\RtxService
IF NOT EXIST %fullpath% (
	echo -1
)

dir %fullpath% | find "File(s)" > %logname%.tmp

rem Get size of emergeny logs
for /F "tokens=3" %%a in (%logname%.tmp) Do (echo %%a > %logname%.tmp)

rem remove delims like , in size  1,018,846 --> 1018846
for /F "delims=, tokens=1,2,3,4" %%a in (%logname%.tmp) Do (
	echo %%a%%b%%c%%d > %logname%.sav
	call :count %%a%%b%%c%%d %prevSize%)
del /q %logname%.tmp
goto :eof

:CalcFileName
set ServiceName=%~nx1
set logname=%server:~7%_%ServiceName%_%filemask:~9%
goto :eof

:Count
set a=%1
set b=%2
set /a count=1%a:~-7%-1%b:~-7%
if %count% LSS 0 (echo 0) else (echo %count%)
