# OPL 1-Wire
Organiser II <a href = "https://en.wikipedia.org/wiki/1-Wire">1-Wire</a> code for Top Slot Retro I/O interface or compatible 5 volt interface to Top Slot (e.g. internal COMMS adaptor signals).

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
1-Wire is ideally suited to the Organiser II device as it is a low power half duplex system, designed to support a large number of low power devices. Devices, e.g. Temperature sensors, clocks, authenticators, memory, a/d convertors <a href="https://github.com/nofitnessforpurpose/OPL-1-Wire/blob/main/images/1W-DC-AMPS.jpg">etc.</a> on a 1-Wire network are connected in parallel and can be addressed simultaneously or individually depending on the applicable mode.

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

## Demo Code
<a href="https://github.com/nofitnessforpurpose/OPL-1-Wire/blob/main/code/DS18B20.OPL">DS18B20.OPL</a> is demonstration code that uses the features made available by the basic supporting procedures. In order of typical use they are:
  | Routine | Parameter | Returns | Comment |
  | ------- | --------- | ------- | ------- |       
  | PON:    | None | None | Power on the <a href="https://github.com/nofitnessforpurpose/TopSlotRetroIOBasic"> Top Slot Retro IO Basic</a> |
  | IOB1WSET: | None | None | Set Top Slot Retro IO Basic interface to correct state for subsequent 1-Wire transactions |
  | ONEWRST: | None | Byte | Reset the 1-Wire Micro Lan and return the detected status |
  | SND1WBYT: | Byte | None | Send a single byte e.g. a ROM command | 
  | RD1WSPD$: | String | String | Reads a device scratch pad |
  | ONEWCRC:  | String | Float | Calculate CRC of data in String |
  | POF: | None | None |Turns off the Top Slot |

The demo code DS18B20 is intended to be simple rather than efficient in its use of resource e.g. memory or processing. The machine code routines are for example re-built on every call, adding considerably to overhead in the demo routine. Pre-building the machine code would speed the data acquisition also reducing power consumption. DS18B20x: implements such a scheme minimising Top Slot on period.  
  <BR>

### Connection
Connection to the <a href="https://github.com/nofitnessforpurpose/TopSlotRetroIOBasic"> Top Slot Retro IO Basic</a> requires a diode and resistor. A diode is connected between pin 3 ( D3 ){Andode} and pin 6 ( D4 )  {Cathode}.  A 4k7 resistor is connected between Pin 3 ( D3 ) and Pin 5 ( D0). Pin 4 ( D2 ) is not used and should be pulled low to ground.

| Pin | Function | Circuit & Comment | 1-Wire Function |
| --- | - | - | - |
|  1  |  +5 V | No connection (+5 Volt Orgnaiser internal power) | |
|  2  |  0 V | 0 V | 0 Volt ground reference | GND |
|  3  | D3 |  Diode Anode & Pull Up resistor | 1-Wire Data Line | DQ |
|  4  | D2 | Connect to ground reference | |
|  5  | D0 | +5 Volt 30 mA 1-Wire power (for non parasitic devices) & Pull up resistor | Vdd (Power) |
|  6  | D4 | Diode Cathode, 1-Wire current sink for DQ, connect to 1-Wire DQ via Diode Anode | |

<BR>

### Summary
A standard 1-Wire device (such as th DS18B20) is connected:  

| Pin |  TSRIOB Pin | 1-Wire Function |
| --- | - | - |
|  1  | Pin 2 - 0 V | Ground reference|
|  2  | Pin 3 - D3 | DQ line|
|  3  | Pin 5 - D0 | Vdd (+ 5 volt power)|

<BR>

### Signals
1-wire signals are typically 0 to 5 volt (3 Volt devices are becoming available) having signals as shown below:
<div align="center">
  <div style="display: flex; align-items: flex-start;">
  <img src="https://github.com/nofitnessforpurpose/OPL-1-Wire/blob/main/images/1-Wire%20Waveform%20Graphic.jpg?raw=true" width="400px" alt="NotFitForPurpose DS18B20 signals. Image copyright (c) 21 December 2024 nofitnessforpurpose All Rights Reserved">
  </div>
</div>
<BR>
The Controller (in this case the Organiser II) signals are shown in yellow / gold. The target device signals e.g. a DS18B20 temperature sensor, i-button etc. are shown in dark green. It Will be seen from the signal traces that the controller initiates all transaction over the 1-Wire network.   

Periods (in uS) are (approximate):
|  Label | Period |
| ------ | ------ |
|   A    |   15   |
|   B    |   45   |
|   C    |   60   |
|   D    |    5   |
|   E    |   15   |
|   F    |   40   |
|   G    |    5   |
|   H    |  480   |
|   I    |   15   |
|   J    |   15   |

<BR>

## Discussion  
The files must be run from the A: or D: drive during the period over which the Top Slot is active.  

Only the OPL files are required along with the interface, the assembly files are not required.  

### Running
Copy the OPL files to the A: drive and run DS18B20 when a 1-Wire temperature sensor is connected as described above.  

The ROM Search utility has not been implemented at this time, there are two options:
  1) For multi device Micro Lans, address devices directly using a devices known address via the MATCH ROM command 
  2) Use only a single device
     
<BR>

## Limitations  
The current iteration supports 1-Wire standard mode only.

Where no Top Slot ROM is used for the 1-Wire code base, code accessing the Top Slot must reside on the internal A: storage location.
As power and data for the 1-Wire network is sourced from the Top-Slot and uses the internal data bus, a 1-Wire transaction sequence must complete before accessing B: or C: storage locations. i.e. Calling POF:, or equivalent to terminate Top Slot use.    

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
