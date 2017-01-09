add wave -noupdate /tb_bcd_6digit/rst_n
add wave -noupdate /tb_bcd_6digit/clk
add wave -noupdate /tb_bcd_6digit/cnt_en
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_bcd_6digit/bcd_S1
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_bcd_6digit/bcd_S2
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_bcd_6digit/bcd_M1
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_bcd_6digit/bcd_M2
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_bcd_6digit/bcd_H1
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_bcd_6digit/bcd_H2
add wave -noupdate /tb_bcd_6digit/update_H1
add wave -noupdate /tb_bcd_6digit/update_count
add wave -noupdate /tb_bcd_6digit/run_sim
add wave -noupdate /tb_bcd_6digit/action
wave zoom full
