`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:51:10 08/25/2015 
// Design Name: 
// Module Name:    control 
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
module control(
	mode,
	s_switch,
	lap, 
	set,
	t_switch,
	up1,
	up0,
	clk,
	rst_n,
	pulse0,
	pulse1,
	pulse2
);

localparam STOPWATCH=1'b0;
localparam TIMER=1'b1;

output mode;
output s_switch,lap;
output [1:0]set;
output t_switch,up1,up0;

input clk,rst_n;
input pulse0,pulse1,pulse2;

reg mode,next_mode;
reg s_switch,lap,next_s_switch,next_lap;
reg [1:0]set,next_set;
reg t_switch,up0,up1,next_t_switch,next_up0,next_up1;

always@(posedge clk or negedge rst_n)
	if(~rst_n) begin
		mode <= STOPWATCH;
		s_switch <= 1'b0;
		lap <= 1'b0;
		set <= 2'b00;
		t_switch <= 1'b0;
		up0 <= 1'b0;
		up1 <= 1'b1;		
	end
	else begin
		mode <= next_mode;
		s_switch <= next_s_switch;
		lap <= next_lap;
		set <= next_set;
		t_switch <= next_t_switch;
		up0 <= next_up0;
		up1 <= next_up1;	
	end		
		
always@(*)
  case(mode)
	STOPWATCH : begin
		if(pulse0||pulse1||pulse2) begin
			next_mode = pulse0 ? ~mode : mode;
			next_s_switch = pulse1 ? ~s_switch : s_switch;
			next_lap = pulse2 ? ~lap : lap;
			next_set = 2'b00;
			next_t_switch = 1'b0;
			next_up0 = 1'b0;
			next_up1 = 1'b0;
		end
		else begin
			next_mode = mode;
			next_s_switch = s_switch;
			next_lap = lap;
			next_set = 2'b00;
			next_t_switch = 1'b0;
			next_up0 = 1'b0;
			next_up1 = 1'b0;
		end	
	end
	TIMER : begin
		if(set==2'b00) begin
			next_mode = pulse0 ? ~mode : mode;
			next_s_switch = 1'b0;
			next_lap = 1'b0;
			next_set = pulse2 ? 2'b01 : set;
			next_t_switch = pulse1 ? ~t_switch : t_switch;
			next_up0 = 1'b0;
			next_up1 = 1'b0;
		end
		else if(set==2'b01) begin
			next_mode = pulse0 ? ~mode : mode;
			next_s_switch = 1'b0;
			next_lap = 1'b0;
			next_set = pulse2 ? 2'b10 : set;
			next_t_switch = 1'b0;
			next_up0 = pulse1 ? 1'b1 : 1'b0;
			next_up1 = 1'b0;
		end
		else if(set==2'b10) begin
			next_mode = pulse0 ? ~mode : mode;
			next_s_switch = 1'b0;
			next_lap = 1'b0;
			next_set = pulse2 ? 2'b00 : set;
			next_t_switch = 1'b0;
			next_up0 = 1'b0;
			next_up1 = pulse1 ? 1'b1 : 1'b0;
		end
		else begin
			next_mode = pulse0 ? ~mode : mode;
			next_s_switch = 1'b0;
			next_lap = 1'b0;
			next_set = set;
			next_t_switch = 1'b0;
			next_up0 = 1'b0;
			next_up1 = 1'b0;
		end		
	end
	default : begin
		next_mode = mode;
		next_s_switch = 1'b0;
		next_lap = 1'b0;
		next_set = 2'b00;
		next_t_switch = 1'b0;
		next_up0 = 1'b0;
		next_up1 = 1'b0;
	end
  endcase


endmodule
