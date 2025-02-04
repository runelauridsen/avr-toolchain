@echo off
setlocal

for %%a in (%*) do set "%%a=1" & rem convert arguments to variables
cd /d %~dp0                    & rem move to same directory as example.bat
call toolchain.bat             & rem make sure tools from /toolchain is in %path%

if "%listen%%port%" == "1" echo Please specify COM port with e.g. 'set port=COM3' before running this script && goto fail

if "%clean%" == "1" echo [clean] && rmdir build /s /q 2> NUL
mkdir build generated 2> NUL
cd build

if "%build%"   == "1" echo [build]  && avr-gcc ../example.c -o example.o -mmcu=atmega2560 -D F_CPU=16000000 && avr-objcopy.exe -O ihex example.o example.hex || goto fail
if "%flash%"   == "1" echo [flash]  && avrdude -p atmega2560 -c wiring -P \\.\%port% -b115200 -D -Uflash:w:example.hex:i || goto fail
if "%listen%"  == "1" echo [listen] && plink -serial %port% -sercfg 9600,8,n,1,N || goto fail

:done
echo [92mSucceeded[0m && exit /b 0
:fail
echo [91mFailed[0m && exit /b 1
