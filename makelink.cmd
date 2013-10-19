@echo off
chcp 65001
if not exist "c:/var/" (
    mkdir "c:/var/"
)
if not exist "c:/var/guides/" (
    mklink /d /h /j "c:/var/guides" "%CD%"
) else (
    echo ---
    echo Удали папку c:/var/guides/ к едрени матери
    echo ---
)
pause