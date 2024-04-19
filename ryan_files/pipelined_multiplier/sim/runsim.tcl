
# launch ModelSim in command line mode (vsim -c) and then source this
# script to run simulation

set RTL_DIR ../rtl
set SIM_DIR .
set SYNTH_DIR ../synth/rpt

#create new project in current directory
project new $SIM_DIR name

# the project source files
project addfile $RTL_DIR/matrix_pipeline.v
project addfile $RTL_DIR/loader.v
#project addfile $SYNTH_DIR/netlist.v
project addfile $RTL_DIR/testbench.v


# add the post-synth tile to project and add the std cells that are
# needed when simulating the post-synthesis tile 

project addfile $RTL_DIR/slow_vdd1v0_basicCells.v

# compile, load simulation, and then run sim to the end
project compileall

vsim work.testbench
add wave -r *

run -all
quit -sim

# close out the project
project close
exit