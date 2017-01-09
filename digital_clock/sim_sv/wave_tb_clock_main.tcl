add wave -noupdate /tb_clock_main/button_sm
add wave -noupdate /tb_clock_main/button_count
add wave -noupdate /tb_clock_main/button_sec_enable
add wave -noupdate /tb_clock_main/state
add wave -noupdate /tb_clock_main/seg0
add wave -noupdate /tb_clock_main/seg1
add wave -noupdate /tb_clock_main/seg2
add wave -noupdate /tb_clock_main/seg3
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_clock_main/dut/bcd3
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_clock_main/dut/bcd2
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_clock_main/dut/bcd1
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_clock_main/dut/bcd0
wave zoom full
