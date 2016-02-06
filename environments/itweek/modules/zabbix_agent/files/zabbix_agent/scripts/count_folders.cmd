@echo off 
set logname=NumberOfFolders
dir /a:d /b %1 > %logname%.tmp
for /F "tokens=1" %%a in (%logname%.tmp) Do (set result=%%a)
IF [%result%]==[] (
			echo 0
			) ELSE (
				dir /a:d /b %1 | find /c /v "Hell"
			)
del /q %logname%.tmp