@echo off
setlocal

:: serial port as first argument
if "%1" == "" (
    echo.
    echo Please specify COM port. Usage:
    echo.
    echo    example.bat COM5
    goto :done
)
set port=%1
set baud=9600

:: output artifacts to .\build
if not exist build mkdir build

:: compile
toolchain\windows\avr8-gnu-toolchain-win32_x86_64\bin\avr-gcc.exe example.c -o build\example.o -mmcu=atmega2560 -D F_CPU=16000000 || goto done

:: generate hex file
toolchain\windows\avr8-gnu-toolchain-win32_x86_64\bin\avr-objcopy.exe -O ihex build\example.o build\example.hex || goto done

:: upload
toolchain\windows\avrdude-v7.3-windows-x64\avrdude.exe -p atmega2560 -c wiring -P \\.\%port% -b115200 -D -Uflash:w:build\example.hex:i || goto done

:: listen on serial port
echo Listing for serial output from %port%. Press Ctrl+C to exit.
toolchain\windows\putty\plink.exe -serial %port% -sercfg %baud%,8,n,1,N || goto done

:done
endlocal
