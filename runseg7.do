# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./counter2.sv"
vlog "./bounds.sv"
vlog "./seg7.sv"
vlog "./useInput.sv"
vlog "./DE1_SoC.sv"
vlog "./centerLight.sv"
vlog "./normalLight.sv"
vlog "./random.sv"
vlog "./compare.sv"
vlog "./matrix_driver.sv"
vlog "./counter1.sv"
vlog "./startColumn.sv"
vlog "./counter3.sv"
vlog "./normalColumn.sv"
vlog "./collision.sv"
vlog "./score.sv"
vlog "./increment.sv"
vlog "./highscore.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work seg7_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do seg7_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
