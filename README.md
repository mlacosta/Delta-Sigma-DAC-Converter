# Delta-Sigma-DAC-Converter

**Author:** Mariano Leonel Acosta <br>
**Date:** March 2018

In this project I designed a Digital to Analog Converter in VHDL. It comes handy for FPGA development boards that lacks a D/A. Particularly, I used it on the Zybo board from Digilent. 

## Inputs
**data:** Signed integer (24 bits) <br>
**clk:** Clock Signal

## Outputs
**dac_out:** Binary (1 bit). Pulse Density Modulation (PDM) Signal. In order to recover the baseline signal, this output has to be low-pass filtered in the analog domain.  
