@echo off

rem This file is UTF-8 encoded, so we need to update the current code page while executing it
for /f "tokens=2 delims=:." %%a in ('"%SystemRoot%\System32\chcp.com"') do (
    set _OLD_CODEPAGE=%%a
)
if defined _OLD_CODEPAGE (
    "%SystemRoot%\System32\chcp.com" 65001 > nul
)

<<<<<<< HEAD:.venvFlask/Scripts/activate.bat
set VIRTUAL_ENV=D:\blockchain lesson\project\LoT-project\.venvFlask
=======
set "VIRTUAL_ENV=F:\Document\IoT\LoT project\.venvIoTFlask"
>>>>>>> 21a41240b5aaf96c5871187d915d4d9d9665bb56:.venvIoTFlask/Scripts/activate.bat

if not defined PROMPT set PROMPT=$P$G

if defined _OLD_VIRTUAL_PROMPT set PROMPT=%_OLD_VIRTUAL_PROMPT%
if defined _OLD_VIRTUAL_PYTHONHOME set PYTHONHOME=%_OLD_VIRTUAL_PYTHONHOME%

<<<<<<< HEAD:.venvFlask/Scripts/activate.bat
set "_OLD_VIRTUAL_PROMPT=%PROMPT%"
set "PROMPT=(.venvFlask) %PROMPT%"
=======
set _OLD_VIRTUAL_PROMPT=%PROMPT%
set PROMPT=(.venvIoTFlask) %PROMPT%
>>>>>>> 21a41240b5aaf96c5871187d915d4d9d9665bb56:.venvIoTFlask/Scripts/activate.bat

if defined PYTHONHOME set _OLD_VIRTUAL_PYTHONHOME=%PYTHONHOME%
set PYTHONHOME=

if defined _OLD_VIRTUAL_PATH set PATH=%_OLD_VIRTUAL_PATH%
if not defined _OLD_VIRTUAL_PATH set _OLD_VIRTUAL_PATH=%PATH%

<<<<<<< HEAD:.venvFlask/Scripts/activate.bat
set PATH=%VIRTUAL_ENV%\Scripts;%PATH%
set VIRTUAL_ENV_PROMPT=.venvFlask
=======
set "PATH=%VIRTUAL_ENV%\Scripts;%PATH%"
set "VIRTUAL_ENV_PROMPT=(.venvIoTFlask) "
>>>>>>> 21a41240b5aaf96c5871187d915d4d9d9665bb56:.venvIoTFlask/Scripts/activate.bat

:END
if defined _OLD_CODEPAGE (
    "%SystemRoot%\System32\chcp.com" %_OLD_CODEPAGE% > nul
    set _OLD_CODEPAGE=
)
