@echo off
rem ---------------------------------------------------------------------------
rem Script for running MActor tests (files of type test, test_run and mock_battery) 
rem
rem Required Environment Variables
rem
rem   JAVA_HOME       Points to the Java Development Kit installation.
rem
rem Optional Environment Variables
rem 
rem   MACTOR_HOME    Points to the MActor installation directory.
rem
rem ---------------------------------------------------------------------------

if "%OS%" == "Windows_NT" setlocal

if not "%JAVA_HOME%" == "" goto gotJavaHome
echo The JAVA_HOME environment variable is not set.
echo This is required to run MActor.
exit /B 1

:gotJavaHome

if exist "%JAVA_HOME%\bin\java.exe" goto okJavaHome
echo The JAVA_HOME environment variable is not set correctly.
echo This is required to run MActor.
exit /B 1

:okJavaHome

if not "%MACTOR_HOME%" == "" goto gotMActorHome
set MACTOR_HOME=..
if exist "%MACTOR_HOME%\bin\setenv.bat" goto okMActorHome
set MACTOR_HOME=.
if exist "%MACTOR_HOME%\bin\setenv.bat" goto okMActorHome
echo The MACTOR_HOME variable is not correctly set.
echo This is required to run MActor.
exit /B 1

:gotMActorHome

if exist "%MACTOR_HOME%\bin\gui.bat" goto okMActorHome
echo The MACTOR_HOME variable is not set correctly.
echo This is required to run MActor.
exit /B 1

:okMActorHome

set CLASSPATH=
if exist "%MACTOR_HOME%\bin\setenv.bat" call "%MACTOR_HOME%\bin\setenv.bat"

rem Execute the requested command

echo Using MACTOR_HOME: %MACTOR_HOME%
echo Using JAVA_HOME:    %JAVA_HOME%
echo Using CLASSPATH:    %CLASSPATH%

:doRun

set CMD_LINE_ARGS=
:setArgs
if ""%1""=="""" goto doneSetArgs
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto setArgs
:doneSetArgs

rem Execute Java with the applicable properties

echo Note that MActor 2.0.1 or newer requieres Java Runtime 1.6 or newer

"%JAVA_HOME%\bin\java"  -classpath %CLASSPATH% -Xmx500M  -Dfile.encoding=UTF-8 org.mactor.ui.cmd.MActorCmd %CMD_LINE_ARGS%
