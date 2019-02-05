onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /winner_testbench/clk
add wave -noupdate /winner_testbench/reset
add wave -noupdate -expand /winner_testbench/number
add wave -noupdate /winner_testbench/reset_play
add wave -noupdate /winner_testbench/this_player
add wave -noupdate /winner_testbench/other_player
add wave -noupdate /winner_testbench/this_light
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 157
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {990 ps}
