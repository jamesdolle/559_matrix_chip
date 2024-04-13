

# launch ModelSim in command line mode (vsim -c) and then source this
# script to run simulation

set SIM_DIR .

project new $SIM_DIR name

project addfile data_loader_tb.sv
project addfile data_loader.sv

project compileall

vsim work.data_loader_tb
run -all
add wave *

#quit -sim

# close out the project
#project close
#exit