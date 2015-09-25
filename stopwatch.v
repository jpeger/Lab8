`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:51:47 08/25/2015 
// Design Name: 
// Module Name:    stopwatch 
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
module stopwatch(
	out0,
	out1,
	out2,
	out3,
	clk,
	rst_n,
	mode,
	lap,
	switch,
	zero	
);

localparam STOPWATCH=1'b0;
localparam TIMER=1'b1;

output [3:0]out0,out1,out2,out3;
input clk,rst_n;
input mode,lap,switch,zero;

wire [3:0]v0,v1,v2,v3;
reg [3:0]out0,out1,out2,out3,tmp0,tmp1,tmp2,tmp3;

up_cnt S0(
   .out0(v0),
	.out1(v1),
	.out2(v2),
	.out3(v3),
	.clk(clk),
	.rst_n(rst_n),
	.en(switch),
	.zero(zero)
);

always@(*)
	if(lap==1'b1) begin
		out0 = tmp0;
		out1 = tmp1;
		out2 = tmp2;
		out3 = tmp3;
	end
	else begin
		out0 = v0;
		out1 = v1;
		out2 = v2;
		out3 = v3;
		tmp0 = v0;
		tmp1 = v1;
		tmp2 = v2;
		tmp3 = v3;
	end

endmodule
