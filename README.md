# OPL 1-Wire
Organiser II 1-wire code for Top Slot Retro I/O interface or compatible 5 volt COMMS interface to top slot.

This <a href="https://en.wikipedia.org/wiki/Psion_Organiser">Psion Orgnaiser II</a> <a href="https://en.wikipedia.org/wiki/Open_Programming_Language">OPL program</a> uses the Top Slot Retro IO Basic interface (or compatible COMMS 5 volt signals) to access <a href = "https://en.wikipedia.org/wiki/1-Wire">1-Wire</a> devices. Examples demonstrate accessing a 1-Wire DS18B20 temperature sensor, though any 1-Wire device can be accessed via the interface and supporting protocol.

The Organiser II is also able to emulate a 1-Wire device via additional software.

For a full list of 1-Wire capable devices, see the <a href="https://www.analog.com/en/product-category/1wire-devices.html">manufacturers</a> site.

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
1-Wire is ideally suited to the Organiser II device as it is a low power half duplex system designed to support a large number of low power devices.

<BR>

## Discussion  

<BR>

## Limitations  
The current iteration supports standard mode only.
Where no Top Slot ROM is used for the 1-Wire code base, code accessing the Top Slot must reside on the internal A: storage location.

<BR>

## Considerations
External interfaces using power are limited to 30 mA maximum and should consider the power drain on Organiser II devices using limited battery power.

<BR>

## Questions / Discussion
See <a target="_blank" rel="noopener noreferrer" href="https://www.organiser2.com/"> Organiser 2 Hardware </a> forum, though see note below first.


<BR>

## Please note:  
All information is For Indication only.
No association, affiliation, recommendation, suitability, fitness for purpose should be assumed or is implied.
Registered trademarks are owned by their respective registrants.
