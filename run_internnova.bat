@echo off

set "FLUTTER=C:\Users\RIDDHI~1\flutter\flutter"

cd /d "C:\PROJECTS\internship_management_app\InternNova"

echo ========================================
echo USING FLUTTER:
echo %FLUTTER%
echo ========================================

"%FLUTTER%\bin\flutter.bat" --version

echo.
echo Cleaning project...
"%FLUTTER%\bin\flutter.bat" clean

echo.
echo Getting packages...
"%FLUTTER%\bin\flutter.bat" pub get

echo.
echo Running Edge...
"%FLUTTER%\bin\flutter.bat" run -d edge

pause