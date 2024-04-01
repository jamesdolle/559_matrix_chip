/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : T-2022.03-SP4
// Date      : Tue Mar 19 14:16:12 2024
/////////////////////////////////////////////////////////////


module simple_rtl ( a, clk, S0 );
  input a, clk;
  output S0;


  DFFQXL S0_reg ( .D(a), .CK(clk), .Q(S0) );
endmodule

