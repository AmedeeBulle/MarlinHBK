#!/bin/bash
#
# Clone of _do_make.bat for linux/osx
#
# Usage: _do_make.sh [Suffix] [Defines ...]

# Firmware suffix -- Defaults to HBK
Suffix=${1:-HBK}

# If we have additional parameters, pass them as additional defines to Make
if [ $# -gt 1 ]
then
  shift
  Defines="$*"
else
  Defines=""
fi

# Where is Arduino?
Arduino="/Applications/Arduino-1.0.3.app/Contents/Resources/Java"

PATH="${Arduino}/hardware/tools/avr/bin:${PATH}"

BASE_PARAMS="HARDWARE_MOTHERBOARD=7 ARDUINO_INSTALL_DIR=${Arduino} ARDUINO_VERSION=103"

make ${BASE_PARAMS} BUILD_DIR=_UltimakerMarlin_250000 DEFINES="'VERSION_PROFILE=\"250000_single\"' BAUDRATE=250000 TEMP_SENSOR_1=0 EXTRUDERS=1 ${Defines}"
make ${BASE_PARAMS} BUILD_DIR=_UltimakerMarlin_115200 DEFINES="'VERSION_PROFILE=\"115200_single\"' BAUDRATE=115200 TEMP_SENSOR_1=0 EXTRUDERS=1 ${Defines}"
make ${BASE_PARAMS} BUILD_DIR=_UltimakerMarlin_Dual_250000 DEFINES="'VERSION_PROFILE=\"250000_dual\"' BAUDRATE=250000 TEMP_SENSOR_1=-1 EXTRUDERS=2 ${Defines}"
make ${BASE_PARAMS} BUILD_DIR=_UltimakerMarlin_Dual_115200 DEFINES="'VERSION_PROFILE=\"115200_dual\"' BAUDRATE=115200 TEMP_SENSOR_1=-1 EXTRUDERS=2 ${Defines}"

cp _UltimakerMarlin_250000/Marlin.hex MarlinUltimaker-${Suffix}-250000.hex
cp _UltimakerMarlin_115200/Marlin.hex MarlinUltimaker-${Suffix}-115200.hex
cp _UltimakerMarlin_Dual_250000/Marlin.hex MarlinUltimaker-${Suffix}-250000-dual.hex
cp _UltimakerMarlin_Dual_115200/Marlin.hex MarlinUltimaker-${Suffix}-115200-dual.hex
