@echo off
cd /d %~dp0

set path=%cd%\toolchain\windows\avr8-gnu-toolchain-win32_x86_64\bin;%path%
set path=%cd%\toolchain\windows\avrdude-v7.3-windows-x64;%path%
set path=%cd%toolchain\windows\putty;%path%
