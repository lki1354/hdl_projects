# INIT sim environment
vlib work
vmap work work

# Compile sources
vlog ../src_sv/bcd_6digit.sv
vlog ../src_sv/bcdcnt.sv

# Compile TB
vlog tb_bcd_6digit.sv

# Init simulation
vsim tb_bcd_6digit
do wave_tb_bcd_6digit.tcl
log -r *

# Run simulation
run -all

# Display wave
view wave

wave zoomfull
