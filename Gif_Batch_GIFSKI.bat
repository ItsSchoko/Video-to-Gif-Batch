@ECHO off
:MENU
ECHO.
ECHO.
ECHO       ___^|        ^|             ^|                  ___^|_ _^| ____^|              ^|                       
ECHO     \___ \   __^|  __ \    _ \   ^|  /   _ \        ^| __   ^|  ^|      _` ^|   __^|  __^|   _ \    __^|  ^|   ^| 
ECHO           ^| (     ^| ^| ^|  (   ^|    ^<   (   ^|       ^|   ^|  ^|  __^|   (   ^|  (     ^|    (   ^|  ^|     ^|   ^| 
ECHO     _____/ \___^| _^| ^|_^| \___/  _^|\_\ \___/       \____^|___^|_^|    \__._^| \___^| \__^| \___/  _^|    \__. ^| 
ECHO                                                                                             2021____/
ECHO.
ECHO.


REM Userinput
SET /P Input=Scaling None/Individual/Scale all/GIF to WEBP convertion 1, 2 3 or 4? (Default is 1):

IF [%Input%] equ [] ( GOTO NOSCALE )
IF %Input%==1 GOTO NOSCALE
IF %Input%==2 GOTO SCALE
IF %Input%==3 GOTO SCALEALL
IF %Input%==4 GOTO WEBP

:NOSCALE
ECHO NO SCALE

for %%A in (%*) do (
echo File path "%%~dpA"
echo File path and name "%%~A"
echo File path, name and gif file ext. "%%~dpA%%~nA%.gif"

setlocal EnableDelayedExpansion

REM gets width of the input video
for /F %%i in ('ffprobe -v error -select_streams v:0 -show_entries stream^=width -of default^=nw^=1:nk^=1 "%%~A"') do (
set videowidth=%%i
)

ffmpeg -i "%%~A" -f yuv4mpegpipe - | gifski --quality 95 --width !videowidth! --fps 25 -o "%%~dpA%%~nA.gif" -

endlocal
cls
)
GOTO MENU

:SCALE
ECHO.
ECHO SCALE INDIVIDUAL
for %%A in (%*) do (
ECHO .........................
ECHO.
ECHO Current File: %%~nxA
ECHO.
ECHO .........................
SET /P Scaleinput=New Size: 
setlocal EnableDelayedExpansion
Echo Scaleinput !Scaleinput!

ffmpeg -i "%%~A" -f yuv4mpegpipe - | gifski --quality 95 --width !Scaleinput! --fps 25 -o "%%~dpA%%~nA.gif" -

endlocal
cls
)
GOTO MENU

:SCALEALL
ECHO.
ECHO SCALE ALL
SET /P Scaleinput=New Size: 
for %%A in (%*) do (
ffmpeg -i "%%~A" -f yuv4mpegpipe - | gifski --quality 95 --width %Scaleinput% --fps 25 -o "%%~dpA%%~nA.gif" -
cls
)

GOTO MENU

:WEBP
for %%A in (%*) do (
echo File path "%%~dpA"
echo File path and name "%%~A"
echo File path, name and gif file ext. "%%~dpA%%~nA%.webp"

ffmpeg -i "%%~A" -pix_fmt yuva420p -y -loop 0 "%%~dpA%%~nA.webp"
cls
)
GOTO MENU


