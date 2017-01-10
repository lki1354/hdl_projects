#digital clock project
A digital clock implementation on an FPGA device.
The clock was testet with a development board "Cyclone V GX Starter Kit" from terasic. 

## introduction
The implementation use the 50MHz clock from the eval board. 
The module clock_divider creates a 1Hz clock for the clock counter.
With 6 BCD counter the module bcd_6digit is a clock counter realised.
For configuration and interact with the clock 3 modules are used. Debounce, key_long_short and clock_sm modules are used for this.
The sevenseg_decoder module converts the binary value to the right number for the seven-segment display.

## operating instructions
*  how to use:
  1.  Switch 0 has to be turn up to enable the clock counter.
  2.  Press key 0 to switch between hour:minute to minute:second and back.
  3.  Press key 0 longer than 0.5 seconds to switch to configuration mode. Configuration number blinks.
  4.  You can count up with key 1.
  5.  To go to the next postion press key 0.
* demonstration video: https://youtu.be/4F-KWqsFQXU
