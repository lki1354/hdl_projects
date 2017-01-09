# INIT sim environment
vlib work
vmap work work

# Compile sources
vlog ../src_sv/bcdcnt.sv

# Compile TB
vlog tb_bcdcnt.sv

# Init simulation
vsim tb_bcdcnt
do wave_tb_bcdcnt.tcl
log -r *

# Run simulation 
run -all

# Display wave
view wave
#do wave_tb_bcdcnt.tcl
wave zoomfull