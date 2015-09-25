`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:03:59 08/13/2015 
// Design Name: 
// Module Name:    down_counter 
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
module down_cnt(
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
	set,
	switch
);

output [3:0]out0,out1,out2,out3;
input clk,rst_n;
input [3:0]in0,in1,in2,in3;
input [1:0]set;
input switch;

reg [3:0]out0,out1,out2,out3;
reg [3:0]next_out0,next_out1,next_out2,next_out3;


always@(posedge clk or negedge rst_n)
	if(~rst_n) begin
		out0 <= 4'd0;
		out1 <= 4'd0;
		out2 <= 4'd0;
		out3 <= 4'd0;
	end
	else begin
		out0 <= next_out0;
		out1 <= next_out1;
		out2 <= next_out2;
		out3 <= next_out3;
	end

always@(*)
  case(set)
	2'b00 : begin
		if(switch==1'b1) begin
			if(out3==4'd0 && out2==4'd0 && out1==4'd0 && out0==4'd0) begin //min value 00:00
				next_out0 = out0;
				next_out1 = out1;
				next_out2 = out2;
				next_out3 = out3;
			end
			else if(out3>4'd0 && out2==4'd0 && out1==4'd0 && out0==4'd0) begin //X0:00
				next_out0 = 4'd9;
				next_out1 = 4'd5;
				next_out2 = 4'd9;
				next_out3 = out3 - 4'd1;
			end
			else if(out2>4'd0 && out1==4'd0 && out0==4'd0) begin //YX:00
				next_out0 = 4'd9;
				next_out1 = 4'd5;
				next_out2 = out2 - 4'd1;
				next_out3 = out3;
			end
			else if(out1>4'd0 && out0==4'd0) begin //YY:X0
				next_out0 = 4'd9;
				next_out1 = out1 - 4'd1;
				next_out2 = out2;
				next_out3 = out3;
			end
			else begin
				next_out0 = out0 - 4'd1;
				next_out1 = out1;
				next_out2 = out2;
				next_out3 = out3;
			end
		end
		else begin
			next_out0 = out0;
			next_out1 = out1;
			next_out2 = out2;
			next_out3 = out3;
		end
	end
	2'b01 : begin
		next_out0 = in0;
		next_out1 = in1;
		next_out2 = in2;
		next_out3 = in3;
	end
	2'b10 : begin
		next_out0 = in0;
		next_out1 = in1;
		next_out2 = in2;
		next_out3 = in3;
	end
	default : begin
		next_out0 = out0;
		next_out1 = out1;
		next_out2 = out2;
		next_out3 = out3;
	end
	
  endcase
	
endmodule