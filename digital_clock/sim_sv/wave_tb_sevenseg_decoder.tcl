add wave -noupdate -color Cyan -itemcolor Cyan -radix unsigned /tb_sevenseg_decoder/bcd
add wave -noupdate -color Cyan -format Analog-Step -height 80 -itemcolor Cyan -max 15.0 -radix unsigned /tb_sevenseg_decoder/bcd
add wave -noupdate /tb_sevenseg_decoder/sevenseg
add wave -noupdate /tb_sevenseg_decoder/sevenseg_n
wave zoom full
