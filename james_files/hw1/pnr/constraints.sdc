###################################################################

# Created by write_sdc on Tue Mar 19 14:16:09 2024

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_max_area 0
set_driving_cell -lib_cell DFFRX1 -pin Q [get_ports a]
set_load -pin_load 0.000207334 [get_ports S0]
create_clock [get_ports clk]  -period 11  -waveform {0 5.5}
set_clock_uncertainty 0.05  [get_clocks clk]
set_input_delay -clock clk  0.1  [get_ports a]
set_output_delay -clock clk  0.4  [get_ports S0]
