::**************************************
:: 1-Wire build
::  
:: (c) Copyright 2024 nofitnessforpurpose All Rights Reserved
:: Revision : 0.1
:: Modified : NotFitForPurpose
:: Date     : 09 Dec 2024
:: Hardware : Psion Organiser II
:: Progam   : Use XA.EXE
::
:: Requires : OSVARS.INC, OSHEAD.INC, OSEROR.INC, SWI.INC 
::**************************************
::
xa -o iob1wset -l iob1wset iob1wset.asm
xa -o onewcrc -l onewcrc onewcrc.asm
xa -o onewrst -l onewrst onewrst.asm
xa -o recbyts -l recbyts recbyts.asm
xa -o sndbyte -l sndbyte sndbyte.asm
xa -o tsof01 -l tsof01 tsof01.asm
xa -o tson01 -l tson01 tson01.asm

