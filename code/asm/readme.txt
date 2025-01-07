(c) Copyright 2024, 2025 nofitnessforpurpose All Rights Reserved
Revision : 0.1
Modified : NotFitForPurpose
Date     : 05 Jan 2025
Hardware : Top Slot Retro IO Basic



Assembly language files for Organiser II 1- Wire Using Top Slot Retro IO Basic
These files create the assembly code contained in the OPL files

The files are assembled with the XA.EXE cross assembler version 1.2
The following include files are typically required:
  osvars.inc
  oseror.inc
  oshead.inc
  swi.inc

The file assemble.bat would assemble all the files with the correct command line parameters.
The assembled code is typically extracted and placed into an OPL procedure that acts to call the machine code.
The machine code is held in the procedure as a hexadecimal string.
