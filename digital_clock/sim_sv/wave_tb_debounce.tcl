add wave -noupdate /tb_debounce/rst_n
add wave -noupdate /tb_debounce/clk
add wave -noupdate /tb_debounce/button
add wave -noupdate /tb_debounce/valid_ff
add wave -noupdate /tb_debounce/valid_pulse
add wave -noupdate /tb_debounce/run_sim
add wave -noupdate /tb_debounce/action
add wave -noupdate -format Analog-Step -height 80 -max 511.0 -radix unsigned /tb_debounce/dut/counter
wave zoom full
