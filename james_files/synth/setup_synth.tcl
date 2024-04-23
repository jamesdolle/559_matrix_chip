
#####################################################################
# setup.tcl
#####################################################################

# set variable CLK_NAME. Script will use this later to tell Design
# Compiler that the net with this name is a clock signal.
set CLK_NAME CLK


# set variable "MOD_NAME" to tell Design Compiler the name of the
# topmost module that you want it to synthesize.
#set MOD_NAME accumulator_ha
set MOD_NAME data_loader

# set variable "REPORT_DIR" to be the output directory
# w.r.t. synthesis directory. The reports will be placed there. When
# running multiple runs, give each one a different REPORT_DIR name so
# that the results will not overwrite prior runs.
set RPT_DIR rpt
file mkdir $RPT_DIR


# initialize link and synthetic libraries
set synthetic_library [list dw_foundation.sldb]
set link_library [list gpdk045_slow.db]
set target_library gpdk045_slow.db

# directory where to put the outputs that are needed by PNR, relative
# to the synthesis directory
set PNR_DIR ../pnr/

# read in the names of all the files containing the verilog modules
# variable "RTL_DIR" to the HDL directory w.r.t synthesis directory
set RTL_DIR ../mult_and_loader_v4_dc_shell/
#read_verilog $RTL_DIR/accumulator_fa.v
#read_verilog $RTL_DIR/accumulator_ha.v
#read_verilog $RTL_DIR/Tile.v

read_verilog $RTL_DIR/matrix.sv
read_verilog $RTL_DIR/DflopX4.sv
read_verilog $RTL_DIR/data_loader.sv

#read_verilog RTL_DIR/simple_rtl.v

# Set the current design to the name of the top level instance you are
# working on. Otherwise tool doesn't know which module from RTL to use
current_design $MOD_NAME


#set the number of digits to be used for delay/power results
set report_default_significant_digits 4