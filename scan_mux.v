`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:08:42 08/25/2015 
// Design Name: 
// Module Name:    scan_mux 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module scan_mux(
	scan0,
	scan1,
	scan2,
	scan3,
	mode,
	t_out0,
	t_out1,
	t_out2,
	t_out3,
	s_out0,
	s_out1,
	s_out2,
	s_out3
);

output [3:0]scan0,scan1,scan2,scan3;
input mode;
input [3:0]t_out0,t_out1,t_out2,t_out3;
input [3:0]s_out0,s_out1,s_out2,s_out3;

assign scan0 = mode ? t_out0 : s_out0;
assign scan1 = mode ? t_out1 : s_out1;
assign scan2 = mode ? t_out2 : s_out2;
assign scan3 = mode ? t_out3 : s_out3;


endmodule
