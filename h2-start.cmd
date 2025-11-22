@echo off
setlocal enabledelayedexpansion

REM --- Setup environment ---
set DIR=db
set H2_VERSION=2.4.240
set H2_JAR=h2-%H2_VERSION%.jar
set H2_DOWNLOAD=https://repo1.maven.org/maven2/com/h2database/h2/%H2_VERSION%/%H2_JAR%
set H2_FILE=%DIR%\%H2_JAR%

REM --- Create directory if missing ---
if not exist "%DIR%" (
    mkdir "%DIR%"
)

REM --- Install H2 if missing ---
if not exist "%H2_FILE%" (
    echo H2 database not found. Installing...

    REM Windows 10/11 haben curl vorinstalliert
    curl -L -o "%H2_FILE%" "%H2_DOWNLOAD%"

    if errorlevel 1 (
        echo Fehler beim Download!
        exit /b 1
    )

    echo H2 database installed.
)

REM --- Start H2 server ---
cd "%DIR%"
java -cp "%H2_JAR%" org.h2.tools.Server -tcpPort 9092 -webPort 19999 -baseDir . -ifNotExists
