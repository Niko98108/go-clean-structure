@echo off
setlocal enabledelayedexpansion

:: Define the structure of the project
set "project_name=%~1"

if "%project_name%"=="" (
    echo Please provide a project name.
    exit /b 1
)

set "root_dir=%cd%\%project_name%"

:: Create the project directory
mkdir "%root_dir%"
cd "%root_dir%"

:: Initialize a new Go module
go mod init %project_name%

:: Create standard directories
set "dirs=cmd config constant doc internal keys release-note repositories test transport usercases"

for %%d in (%dirs%) do (
    mkdir "%%d"
)

:: Create a basic main.go file in cmd directory
(
    echo package main
    echo.
	echo //import bootstrap internal package
    echo.
    echo //func main^(^) {
    echo     //internal.Init^(^)
    echo //}
) > cmd\main.go
(
    echo package constant
) > constant\constant.go

(
    echo package internal
) > internal\bootstrap.go

(
    echo package keys
) > keys\context.go

:: Create a README file
(
    echo # %project_name%
    echo.
    echo This is a basic Go project scaffold created by a custom script.
) > README.md

:: Create a .gitignore file
(
    echo /bin/
    echo /pkg/
    echo /vendor/
) > .gitignore

echo Project %project_name% created successfully!

:: Initialize a new Go Sum File
go mod tidy

:: Open the project directory in Visual Studio Code (optional)
code .

endlocal
