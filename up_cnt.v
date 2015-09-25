`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:02:42 08/18/2015 
// Design Name: 
// Module Name:    up_cnt 
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
module up_cnt(
   out0,
	out1,
	out2,
	out3,
	clk,
	rst_n,
	en,
	zero
);

output [3:0]out0,out1,out2,out3;
input clk,rst_n;
input en,zero;

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
  case({zero,en})
	2'b00 : begin
		next_out0 = out0;
		next_out1 = out1;
		next_out2 = out2;
		next_out3 = out3;
	end
	2'b01 : begin
		if(out3==4'd2 && out2==4'd3 && out1==4'd5 && out0==4'd9) begin //max value 23:59
			next_out0 = out0;
			next_out1 = out1;
			next_out2 = out2;
			next_out3 = out3;
		end
		else if(out3<4'd2 && out2==4'd9 && out1==4'd5 && out0==4'd9) begin //09:59 or 19:59
			next_out0 = 4'd0;
			next_out1 = 4'd0;
			next_out2 = 4'd0;
			next_out3 = out3 + 4'd1;
		end
		else if(out2<4'd9 && out1==4'd5 && out0==4'd9) begin //X8:59 ~ X0:59
			next_out0 = 4'd0;
			next_out1 = 4'd0;
			next_out2 = out2 + 4'd1;
			next_out3 = out3;
		end
		else if(out1<4'd5 && out0==4'd9) begin //XX:49 ~ XX:09
			next_out0 = 4'd0;
			next_out1 = out1 + 4'd1;
			next_out2 = out2;
			next_out3 = out3;
		end
		else begin
			next_out0 = out0 + 4'd1;
			next_out1 = out1;
			next_out2 = out2;
			next_out3 = out3;
		end
	end
	2'b10 : begin
		next_out0 = 4'd0;
		next_out1 = 4'd0;
		next_out2 = 4'd0;
		next_out3 = 4'd0;
	end
	2'b11 : begin
		next_out0 = 4'd0;
		next_out1 = 4'd0;
		next_out2 = 4'd0;
		next_out3 = 4'd0;
	end
	default : begin
		next_out0 = out0;
		next_out1 = out1;
		next_out2 = out2;
		next_out3 = out3;
	end
	
  endcase
	

endmodule
