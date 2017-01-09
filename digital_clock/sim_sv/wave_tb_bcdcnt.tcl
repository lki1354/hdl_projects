onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_bcdcnt/rst_n
add wave -noupdate /tb_bcdcnt/clk
add wave -noupdate /tb_bcdcnt/cnt_en
add wave -noupdate -radix unsigned /tb_bcdcnt/bcd
add wave -noupdate -format Analog-Step -height 74 -max 70.0 -radix unsigned /tb_bcdcnt/bcd
add wave -noupdate /tb_bcdcnt/co
add wave -noupdate /tb_bcdcnt/run_sim
add wave -noupdate /tb_bcdcnt/action
wave zoom full
