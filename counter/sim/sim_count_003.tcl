# INIT sim environment
vlib work
vmap work work

# Compile sources
puts "## Compile sources"
vlog ../src/*.sv

# Compile TB
puts "## Compile TB"
vlog tb_count_003.sv

# Init simulation
puts "## Init simulation"
vsim tb_dut
do wave_tb_dut.tcl
log -r *

# Run simulation
run -all

# Display wave
view wave

wave zoomfull
