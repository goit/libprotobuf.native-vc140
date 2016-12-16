@echo off
setlocal EnableDelayedExpansion

set _version=3.1.0-zlocal
IF NOT "%1"=="" (
  set _version=%1
)

mkdir out

nuget pack libprotobuf.native-vc140.nuspec -outputdirectory out -version %_version% -noninteractive
if ERRORLEVEL 1 (
  exit /b 1
)
