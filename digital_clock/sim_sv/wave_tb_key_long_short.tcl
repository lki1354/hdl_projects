add wave -noupdate /tb/rst_n
add wave -noupdate /tb/clk
add wave -noupdate /tb/button
add wave -noupdate /tb/key_press_long
add wave -noupdate /tb/key_press_short
add wave -noupdate /tb/run_sim
add wave -noupdate /tb/action
add wave -noupdate -format Analog-Step -height 80 -max 511.0 -radix unsigned /tb/dut/counter
wave zoom full
