ECHO off
:MENU
ECHO.
ECHO.
ECHO       ___^|        ^|             ^|                  ___^|_ _^| ____^|              ^|                       
ECHO     \___ \   __^|  __ \    _ \   ^|  /   _ \        ^|      ^|  ^|      _` ^|   __^|  __^|   _ \    __^|  ^|   ^| 
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
ffmpeg -i "%%~A" -filter_complex "[0:v] palettegen" -y "%%~dpA%palette.png"
ffmpeg -i "%%~A" -i palette.png -filter_complex "fps=25[0:v],[0:v][1:v] paletteuse" -y "%%~dpA%%~nA%.gif"
call :DELETEPLAETTE
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
ffmpeg -i "%%~A" -filter_complex "[0:v] palettegen" -y "%%~dpA%palette.png"
ffmpeg -i "%%~A" -i palette.png -filter_complex "fps=25,scale=!Scaleinput!:-1:flags=lanczos[0:v],[0:v][1:v] paletteuse" -y "%%~dpA%%~nA%.gif"
endlocal
call :DELETEPLAETTE
cls
)
GOTO MENU

:SCALEALL
ECHO.
ECHO SCALE ALL
SET /P Scaleinput=New Size: 
for %%A in (%*) do (
ffmpeg -i "%%~A" -filter_complex "[0:v] palettegen" -y "%%~dpA%palette.png"
ffmpeg -i "%%~A" -i palette.png -filter_complex "fps=25,scale=%Scaleinput%:-1:flags=lanczos[0:v],[0:v][1:v] paletteuse" -y "%%~dpA%%~nA%.gif"
call :DELETEPLAETTE
cls
)
GOTO MENU

:WEBP
for %%A in (%*) do (
echo File path "%%~dpA"
echo File path and name "%%~A"
echo File path, name and gif file ext. "%%~dpA%%~nA%.webp"

ffmpeg -i "%%~A" -pix_fmt yuva420p -loop 0 "%%~dpA%%~nA.webp"
)
GOTO MENU

:DeleteTEMP
rmdir /q /s Giftemp

:DELETEPLAETTE
del "%~dp1%palette.png"

