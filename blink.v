`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:49:10 08/25/2015 
// Design Name: 
// Module Name:    blink 
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
module blink(
	out0,
	out1,
	out2,
	out3,
	clk,
	rst_n,
	in0,
	in1,
	in2,
	in3,
	blink
);

output [3:0]out0,out1,out2,out3;
input clk,rst_n;
input [3:0]in0,in1,in2,in3;
input [1:0]blink;

reg [3:0]out0,out1,out2,out3;
reg [3:0]next_out0,next_out1,next_out2,next_out3;

always@(posedge clk or negedge rst_n)
	if(~rst_n) begin
		out0 <= in0;
		out1 <= in1;
		out2 <= in2;
		out3 <= in3;
	end
	else begin
		out0 <= next_out0;
		out1 <= next_out1;
		out2 <= next_out2;
		out3 <= next_out3;
	end

always@(*)
  case(blink)
	2'b01: begin
		if(out0==4'd15 && out1==4'd15) begin
			next_out0 = in0;
			next_out1 = in1;
		end
		else begin
			next_out0 = 4'd15;
			next_out1 = 4'd15;
		end
		next_out2 = in2;
		next_out3 = in3;
	end
	2'b10: begin
		next_out0 = in0;
		next_out1 = in1;
		if(out2==4'd15 && out3==4'd15) begin
			next_out2 = in2;
			next_out3 = in3;
		end
		else begin
			next_out2 = 4'd15;
			next_out3 = 4'd15;
		end
	end
	default: begin
		next_out0 = in0;
		next_out1 = in1;
		next_out2 = in2;
		next_out3 = in3;
	end
  endcase	

endmodule
