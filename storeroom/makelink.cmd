@echo off
chcp 65001
if not exist "c:/storeroom/" (
    mklink /d /h /j "c:/storeroom" "%CD%"
) else (
    echo ---
    echo Удали папку c:/storeroom/ к едрени матери
    echo ---
)
pause