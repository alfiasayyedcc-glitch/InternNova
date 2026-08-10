@echo off
title InternNova Flutter Fix

cd /d "C:\PROJECTS\internship_management_app\InternNova"

echo.
echo ==========================================
echo       INTERN NOVA FLUTTER FIX
echo ==========================================
echo.

echo [1/4] Flutter clean...
call flutter clean

echo.
echo [2/4] Removing .dart_tool...
if exist ".dart_tool" rmdir /s /q ".dart_tool"

echo.
echo [3/4] Getting dependencies...
call flutter pub get

echo.
echo [4/4] Running Flutter on Chrome...
call flutter run -d chrome

echo.
echo ==========================================
echo              FINISHED
echo ==========================================
pause
