`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:19 08/25/2015 
// Design Name: 
// Module Name:    timer 
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
module timer(
	out0,
	out1,
	out2,
	out3,
	clk,
	clk_sec,
	rst_n,
	set,
	up0,
	up1,
	switch
);
	
	
output [3:0]out0,out1,out2,out3;
input clk,rst_n;
input clk_sec;
input [1:0]set;
input up0,up1,switch;

reg [3:0]out0,out1,out2,out3;
reg [3:0]next_out0,next_out1,next_out2,next_out3;
wire [3:0]tmp0,tmp1,tmp2,tmp3;

down_cnt S0(
	.out0(tmp0),
	.out1(tmp1),
	.out2(tmp2),
	.out3(tmp3),
	.clk(clk_sec),
	.in0(out0),
	.in1(out1),
	.in2(out2),
	.in3(out3),
	.rst_n(rst_n),
	.set(set),
	.switch(switch)
);

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
		next_out0 = tmp0;
		next_out1 = tmp1;
		next_out2 = tmp2;
		next_out3 = tmp3;		
	end
	2'b01 : begin
		if(up0==1'b1 && out3==4'd2 && out2==4'd3 && out1==4'd5 && out0==4'd9) begin //23:59->00:00
			next_out0 = 4'd0;
			next_out1 = 4'd0;
			next_out2 = 4'd0;
			next_out3 = 4'd0;		
		end
		else if(up0==1'b1 && out3<4'd2 && out2==4'd9 && out1==4'd5 && out0==4'd9) begin //09:59 or 19:59
			next_out0 = 4'd0;
			next_out1 = 4'd0;
			next_out2 = 4'd0;
			next_out3 = out3 + 4'd1;
		end
		else if(up0==1'b1 && out2<4'd9 && out1==4'd5 && out0==4'd9) begin //X8:59 ~ X0:59
			next_out0 = 4'd0;
			next_out1 = 4'd0;
			next_out2 = out2 + 4'd1;
			next_out3 = out3;
		end
		else if(up0==1'b1 && out1<4'd5 && out0==4'd9) begin //XX:49 ~ XX:09
			next_out0 = 4'd0;
			next_out1 = out1 + 4'd1;
			next_out2 = out2;
			next_out3 = out3;
		end
		else if(up0==1'b1)begin
			next_out0 = out0 + 4'd1;
			next_out1 = out1;
			next_out2 = out2;
			next_out3 = out3;
		end
		else begin
			next_out0 = out0;
			next_out1 = out1;
			next_out2 = out2;
			next_out3 = out3;
		end
	end
	2'b10 : begin
		if(up1==1'b1 && out3==4'd2 && out2==4'd3) begin //23:XX+01:00->00:XX
			next_out0 = out0;
			next_out1 = out1;
			next_out2 = 4'd0;
			next_out3 = 4'd0;		
		end
		else if(up1==1'b1 && out3<4'd2 && out2==4'd9) begin //09:XX or 19:XX
			next_out0 = out0;
			next_out1 = out1;
			next_out2 = 4'd0;
			next_out3 = out3 + 4'd1;
		end
		else if(up1==1'b1) begin //X8:XX ~ X0:XX
			next_out0 = out0;
			next_out1 = out1;
			next_out2 = out2 + 4'd1;
			next_out3 = out3;
		end
		else begin
			next_out0 = out0;
			next_out1 = out1;
			next_out2 = out2;
			next_out3 = out3;
		end
	end
	default : begin
		next_out0 = out0;
		next_out1 = out1;
		next_out2 = out2;
		next_out3 = out3;
	end
	
  endcase

endmodule
