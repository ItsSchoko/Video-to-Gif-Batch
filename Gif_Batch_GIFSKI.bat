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

SET /P Input=Scaling None/Individual/Scale all 1, 2 or 3? (Default is 1):

IF [%Input%] equ [] ( GOTO NOSCALE )
IF %Input%==1 GOTO NOSCALE
IF %Input%==2 GOTO SCALE
IF %Input%==3 GOTO SCALEALL

:NOSCALE
ECHO NO SCALE
rem set videowidth=222


for %%A in (%*) do (
echo File path "%%~dpA"
echo File path and name "%%~A"
echo File path, name and gif file ext. "%%~dpA%%~nA%.gif"
mkdir "%%~dpA%Giftemp"

setlocal EnableDelayedExpansion
for /F %%i in ('ffprobe -v error -select_streams v:0 -show_entries stream^=width -of default^=nw^=1:nk^=1 "%%~A"') do (
set videowidth=%%i
)

ffmpeg -i "%%~A" -filter_complex "fps=25, colormatrix=bt709:bt601, format=rgb24" "%%~dpAGiftemp\frame%%04d.png"
gifski --quality 90 --fast --width !videowidth! --fps 25 -o "%%~dpA%%~nA.gif" "%%~dpAGiftemp\frame"*.png

endlocal
call :DeleteTEMP
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

mkdir "%%~dpA%Giftemp"
ffmpeg -i "%%~A" -filter_complex "fps=25, colormatrix=bt709:bt601, format=rgb24" "%%~dpAGiftemp\frame%%04d.png"
gifski --quality 90 --fast --width !Scaleinput! --fps 25 -o "%%~dpA%%~nA.gif" "%%~dpAGiftemp\frame"*.png

endlocal
call :DeleteTEMP
cls
)
GOTO MENU

:SCALEALL
ECHO.
ECHO SCALE ALL
SET /P Scaleinput=New Size: 
for %%A in (%*) do (

mkdir "%%~dpA%Giftemp"
ffmpeg -i "%%~A" -filter_complex "fps=25, colormatrix=bt709:bt601, format=rgb24" "%%~dpAGiftemp\frame%%04d.png"
gifski --quality 90 --fast --width %Scaleinput% --fps 25 -o "%%~dpA%%~nA.gif" "%%~dpAGiftemp\frame"*.png

call :DeleteTEMP
cls
)
GOTO MENU


:DeleteTEMP
rmdir /q /s Giftemp






