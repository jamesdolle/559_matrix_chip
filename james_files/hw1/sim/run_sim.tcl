

# launch ModelSim in command line mode (vsim -c) and then source this
# script to run simulation

set RTL_DIR ../rtl
set SIM_DIR .

#create new project in current directory
project new $SIM_DIR name

# the project source files
#project addfile $RTL_DIR/ALU32.v
#project addfile $RTL_DIR/Controller.v
#project addfile $RTL_DIR/InstructionDecoder.v
#project addfile $RTL_DIR/Memory.v
#project addfile $RTL_DIR/Processor.v
#project addfile $RTL_DIR/RegisterFile.v
#project addfile $RTL_DIR/crossbar.v
#project addfile $RTL_DIR/matrix5arb.v
#project addfile $RTL_DIR/ram_dp_ar_aw.v
#project addfile $RTL_DIR/route_table.v
#project addfile $RTL_DIR/router.v
#project addfile $RTL_DIR/syn_fifo.v
#project addfile $RTL_DIR/system.v
#project addfile $RTL_DIR/Tile.v

#project addfile Tile_post_synth.v

# RTL and netlist
#project addfile $RTL_DIR/simple_rtl.v
project addfile netlist.v

project addfile $RTL_DIR/slow_vdd1v0_basicCells.v

# Testbench is not actually part of the RTL which is being
# synthesized. The Testbench contains non-synthesizable elements that
# only exist in simulation.
#project addfile $RTL_DIR/Testbench.v

project addfile $RTL_DIR/simple_rtl_tb.v

# add the post-synth tile to project and add the std cells that are
# needed when simulating the post-synthesis tile 
#
# project addfile $RTL_DIR/Tile_post_synth.v
# project addfile $RTL_DIR/slow_vdd1v0_basicCells.v


# add the hex memory files that are needed in simulation
project addfile $SIM_DIR/data_ActiveTile.hex
project addfile $SIM_DIR/inst_ActiveTile.hex
project addfile $SIM_DIR/data_IdleTile.hex
project addfile $SIM_DIR/inst_IdleTile.hex

# compile, load simulation, and then run sim to the end
project compileall

vsim work.simple_rtl_tb
run -all
quit -sim

# close out the project
project close
exit
