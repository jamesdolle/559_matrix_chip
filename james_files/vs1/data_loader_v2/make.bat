@ECHO OFF
iverilog -g2005-sv -o rtl -c compile
vvp rtl
rm rtl
vcd2wlf waveform.vcd waveform2.wlf
