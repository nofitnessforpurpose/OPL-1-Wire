# OPL 1-Wire
Organiser II <a href = "https://en.wikipedia.org/wiki/1-Wire">1-Wire</a> code for Top Slot Retro I/O interface or compatible 5 volt COMMS interface to top slot.

<div align="center">
  <div style="display: flex; align-items: flex-start;">
  <img src="https://github.com/nofitnessforpurpose/OPL-1-Wire/blob/main/images/TSRIO-1W-01.png?raw=true" width="400px" alt="NotFitForPurpose Contraption 02. Image copyright (c) 21 December 2024 nofitnessforpurpose All Rights Reserved">
  </div>
</div>
<BR>

[![Organiser](https://img.shields.io/badge/gadget-Organiser_II-blueviolet.svg?%3D&style=flat-square)](https://en.wikipedia.org/wiki/Psion_Organiser)
[![GitHub License](https://img.shields.io/github/license/nofitnessforpurpose/OPL-1-Wire?style=flat-square)](https://github.com/nofitnessforpurpose/OPL-1-Wire/blob/main/LICENSE)
[![Maintenance](https://img.shields.io/badge/maintained%3F-yes-green.svg?style=flat-square)](https://github.com/nofitnessforpurpose/TopSlotCase/graphs/commit-activity)
![GitHub repo size](https://img.shields.io/github/repo-size/nofitnessforpurpose/OPL-1-Wire?style=flat-square)

<br>  

## Use Case
1-Wire is ideally suited to the Organiser II device as it is a low power half duplex system, designed to support a large number of low power devices. Devices, e.g. Temperature sensors, clocks, authenticators, memory, a/d convertors etc. on a 1-Wire network are connected in parallel and can be addressed simultaneously or individually depending on the applicable mode.

This <a href="https://en.wikipedia.org/wiki/Psion Organiser">Psion Organiser II</a> <a href="https://en.wikipedia.org/wiki/Open_Programming_Language">OPL program</a> uses the <a href="https://github.com/nofitnessforpurpose/TopSlotRetroIOBasic">Top Slot Retro IO Basic</a> interface (or compatible COMMS, 5 volt signals) to access <a href = "https://en.wikipedia.org/wiki/1-Wire">1-Wire</a> devices. Examples demonstrate accessing a 1-Wire DS18B20 temperature sensor, though any 1-Wire device can be accessed via the interface and supporting protocol.

The Organiser II is also able to emulate a 1-Wire device via additional software.  

For a full list of 1-Wire capable devices, see the <a href="https://www.analog.com/en/product-category/1wire-devices.html">manufacturers</a> site.  

Devices such as the ATTiny85, PIC family, CH32V003 or other microcontrollers can be configured with software to act as 1-Wire devices for additional sensors (Seperate power may be required).  

<div align="center">
  <div style="display: flex; align-items: flex-start;">
  <img src="https://github.com/nofitnessforpurpose/OPL-1-Wire/blob/main/images/2025-01-01 22-31-31.gif?raw=true" width="238px" alt="NotFitForPurpose DS18B20. Image copyright (c) 21 December 2024 nofitnessforpurpose All Rights Reserved">
  </div>
</div>
<BR>

## Connection
Connection to the <a href="https://github.com/nofitnessforpurpose/TopSlotRetroIOBasic"> Top Slot Retro IO Basic</a> requires a diode and resistor. A diode is connected between pin 3 ( D3 ){Andode} and pin 6 ( D4 )  {Cathode}.  A 4k7 resistor is connecteb between Pin 3 ( D3 ) and Pin 5 ( D0). Pin 4 ( D2 ) is not used and should be pulled low to ground.

| Pin | Function | Circuit & Comment | 1-Wire Function |
| --- | - | - | - |
|  1  |  +5 V | No connection (+5 Volt Orgnaiser internal power) | |
|  2  |  0 V | 0 V | 0 Volt ground reference | GND |
|  3  | D3 |  Diode Anode & Pull Up resistor | 1-Wire Data Line | DQ |
|  4  | D2 | Connect to ground refernce | |
|  5  | D0 | +5 Volt 30 mA 1-Wire power (for non parasitic devices) & Pull up resistor | Vdd (Power) |
|  6  | D4 | Diode Cathode, 1-Wire current sink for DQ, connect to 1-Wire DQ via Diode Anode | |


### Summary
A standard DS18B20 1-Wire device is connected:  

| Pin |  TSRIOB Pin | 1-Wire Function |
| --- | - | - |
|  1  | Pin 2 - 0 V | Ground reference|
|  2  | Pin 3 - D3 | DQ line|
|  3  | Pin 5 - D0 | Vdd (+ 5 volt power)|



<BR>

## Discussion  
The files must be run from the A: or D: drive during the period over which the Top Slot is active.  

Only the OPL files are required along with the interface, the assembly files are not required.  

### Running
Copy the OPL files to the A: drive and run DS18B20 when a 1-Wire temperature sensor is connected as described above.  

The ROM Search utility has not been implemented at this time, there are two options:
  1) Address devices directly using a known address via the ROM Select command
  2) Use only a single device
     
<BR>

## Limitations  
The current iteration supports 1-Wire standard mode only.

Where no Top Slot ROM is used for the 1-Wire code base, code accessing the Top Slot must reside on the internal A: storage location.
As power and data for the 1-Wire network is sourced from the Top-Slot and uses the internal data bus, a 1-Wire transaction sequence must complete before accessing B: or C: storage locations. i.e. Calling POF:, or equivalent  to terminate Top Slot use.    

<BR>

## Considerations
External interfaces using power are limited to 30 mA maximum and should consider the power drain on Organiser II devices limited battery power.

<BR>

## Questions / Discussion
See <a target="_blank" rel="noopener noreferrer" href="https://www.organiser2.com/"> Organiser 2 Hardware </a> forum, though see note below first.


<BR>

## Please note:  
All information is For Indication only.
No association, affiliation, recommendation, suitability, fitness for purpose should be assumed or is implied.
Registered trademarks are owned by their respective registrants.
