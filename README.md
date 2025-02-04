# AVR toolchain for Windows

Self contained portable toolchain for compiling and uploading to AVR microcontrollers from Windows.

Includes:
- [avr-gcc](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers) for compiling
- [avrdude](https://github.com/avrdudes/avrdude) for uploading
- [plink](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) for serial communication

## Usage

Copy the `toolchain` directory anywhere you like, no installation is required.
- Compile using `toolchain\windows\avr8-gnu-toolchain-win32_x86_64\bin\avr-gcc.exe`
- Generate hex file using `toolchain\windows\avr8-gnu-toolchain-win32_x86_64\bin\avr-objcopy.exe`
- Upload using `toolchain\windows\avrdude-v7.3-windows-x64\avrdude.exe`
- Listen for serial output using `toolchain\windows\putty\plink.exe`

## Example

`toolchain.bat` will prepend the toolchain to your PATH variable.

`example.bat` is a minimal example script that compiles and uploads the `example.c` program to an ATmega2560 microcontroller, and listens for serial output.

Run `set port=COM5 && example.bat build flash listen` (replace `COM5` with whichever port your microcontroller is connected with), to run the example.
