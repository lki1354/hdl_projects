#digital clock project
A digital clock implementation on an FPGA device.
The clock was testet with a development board "Cyclone V GX Starter Kit" from terasic.
Quartus Prime 15.1 was used as development environment for the FPGA.

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

## directory description
* quartus_prime_project: includes all documents to build a design file for the FPGA (*.sof)
* RTL_view: includes all RTL level from the submodules
* sim_sv: all files for testing the submodules
* src_sv: all source files from the submodules

## lessons learned

###	Highlights
* combine the different modules to one toplevel and run the working design on the development board

###	Lowlights
* to simulate, test the toplevel module was hard because the simulation takes a lot of time. Create a one second clock from a 50Hz clock takes much time.

###	Future work
* a short preparation with needs, requirements and a overview of the planned modules (Top Level) is very helpful
* use small modules which are easier to test and verify the functionality

## preparatons
A few preparations are always very important. So for this little project the notes and draws are documented in the preparation_draft_digital_clock.pdf.

