onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /normalColumn_testbench/clk
add wave -noupdate /normalColumn_testbench/reset
add wave -noupdate /normalColumn_testbench/enable2
add wave -noupdate /normalColumn_testbench/ol8
add wave -noupdate /normalColumn_testbench/ol7
add wave -noupdate /normalColumn_testbench/ol6
add wave -noupdate /normalColumn_testbench/ol5
add wave -noupdate /normalColumn_testbench/ol4
add wave -noupdate /normalColumn_testbench/ol3
add wave -noupdate /normalColumn_testbench/ol2
add wave -noupdate /normalColumn_testbench/ol1
add wave -noupdate /normalColumn_testbench/light8
add wave -noupdate /normalColumn_testbench/light7
add wave -noupdate /normalColumn_testbench/light6
add wave -noupdate /normalColumn_testbench/light5
add wave -noupdate /normalColumn_testbench/light4
add wave -noupdate /normalColumn_testbench/light3
add wave -noupdate /normalColumn_testbench/light2
add wave -noupdate /normalColumn_testbench/light1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
