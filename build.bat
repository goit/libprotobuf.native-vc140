@echo off
pushd %~dp0

call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" x86

md install

cd protobuf\cmake
mkdir build & cd build
mkdir debug & cd debug

cmake -G "NMake Makefiles" ^
 -DCMAKE_BUILD_TYPE=Debug ^
 -Dprotobuf_BUILD_TESTS=ON ^
 -Dprotobuf_WITH_ZLIB=ON ^
 -Dprotobuf_MSVC_STATIC_RUNTIME=OFF ^
 -DCMAKE_INSTALL_PREFIX=../../../../install ^
 ../..

nmake

cmake -G "Visual Studio 14 2015" ^
 -Dprotobuf_BUILD_TESTS=ON ^
 -Dprotobuf_WITH_ZLIB=ON ^
 -DCMAKE_INSTALL_PREFIX=../../../../install ^
 ../..

msbuild protobuf.sln /p:Platform=Win32 /nologo /maxcpucount /verbosity:normal /consoleloggerparameters:ErrorsOnly;PerformanceSummary /fileloggerparameters:Verbosity=detailed;LogFile="protobuf_build.log" || goto error

popd

:error
echo Failed!
EXIT /b %ERRORLEVEL%