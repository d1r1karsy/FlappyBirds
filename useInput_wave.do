onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /useInput_testbench/clk
add wave -noupdate /useInput_testbench/reset
add wave -noupdate /useInput_testbench/keyin
add wave -noupdate /useInput_testbench/keyout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {149 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1074 ps}