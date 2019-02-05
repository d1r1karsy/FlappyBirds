onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /random_testbench/clk
add wave -noupdate /random_testbench/reset
add wave -noupdate -radix unsigned -childformat {{{/random_testbench/number[3]} -radix unsigned} {{/random_testbench/number[2]} -radix unsigned} {{/random_testbench/number[1]} -radix unsigned} {{/random_testbench/number[0]} -radix unsigned}} -expand -subitemconfig {{/random_testbench/number[3]} {-radix unsigned} {/random_testbench/number[2]} {-radix unsigned} {/random_testbench/number[1]} {-radix unsigned} {/random_testbench/number[0]} {-radix unsigned}} /random_testbench/number
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {250 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 198
configure wave -valuecolwidth 50
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
WaveRestoreZoom {0 ps} {4148 ps}
