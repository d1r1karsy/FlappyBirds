onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/clk
add wave -noupdate {/DE1_SoC_testbench/SW[9]}
add wave -noupdate {/DE1_SoC_testbench/SW[0]}
add wave -noupdate {/DE1_SoC_testbench/KEY[0]}
add wave -noupdate /DE1_SoC_testbench/dut/green_array
add wave -noupdate /DE1_SoC_testbench/dut/red_array
add wave -noupdate /DE1_SoC_testbench/HEX0
add wave -noupdate /DE1_SoC_testbench/HEX1
add wave -noupdate /DE1_SoC_testbench/HEX2
add wave -noupdate /DE1_SoC_testbench/HEX3
add wave -noupdate /DE1_SoC_testbench/HEX4
add wave -noupdate /DE1_SoC_testbench/HEX5
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1005 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 112
configure wave -valuecolwidth 431
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {3899 ps}
