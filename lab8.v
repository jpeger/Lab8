`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:37:58 08/25/2015 
// Design Name: 
// Module Name:    lab8 
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
module lab8(
	led,
	ftsd_ctl,
	ftseg,
	clk,
	rst_n,
	button0,
	button1,
	button2
);

output [15:0]led;
output [3:0]ftsd_ctl;
output [14:0]ftseg;

input clk,rst_n;
input button0,button1,button2;

wire [25:0]cnt;
wire [3:0]bcd;
wire pulse0,pulse1,pulse2;
wire mode;
wire s_switch,lap,zero;
wire [1:0]set;
wire up0,up1,t_switch;
wire [3:0]s_out0,s_out1,s_out2,s_out3;
wire [3:0]t_out0,t_out1,t_out2,t_out3;
wire [3:0]blink0,blink1,blink2,blink3;
wire [3:0]scan_in0,scan_in1,scan_in2,scan_in3;


assign led[13:0] = (t_out0||t_out1||t_out2||t_out3) ? 14'd0 : 14'b11_1111_1111_1111;
assign led[15:14]= (mode) ? 2'b01 : 2'b10; 	//TIMER : STOPWATCH

freq_div U0(
	.clk(clk),
	.rst_n(rst_n),
	.cnt(cnt)
);

push_button U1(
	.clk(cnt[18]),
	.button(button0),
	.pulse(pulse0),
	.long()
);
push_button U2(
	.clk(cnt[18]),
	.button(button1),
	.pulse(pulse1),
	.long(zero)
);
push_button U3(
	.clk(cnt[18]),
	.button(button2),
	.pulse(pulse2),
	.long()
);

control U4(
	.mode(mode),
	.s_switch(s_switch),
	.lap(lap), 
	.set(set),
	.t_switch(t_switch),
	.up1(up1),
	.up0(up0),
	.clk(cnt[18]),
	.rst_n(rst_n),
	.pulse0(pulse0),
	.pulse1(pulse1),
	.pulse2(pulse2)
);

stopwatch U5(
	.out0(s_out0),
	.out1(s_out1),
	.out2(s_out2),
	.out3(s_out3),
	.clk(cnt[24]),
	.rst_n(rst_n),
	.mode(mode),
	.lap(lap),
	.switch(s_switch),
	.zero(zero)
);

timer U6(
	.out0(blink0),
	.out1(blink1),
	.out2(blink2),
	.out3(blink3),
	.clk(cnt[18]),
	.clk_sec(cnt[24]),
	.rst_n(rst_n),
	.set(set),
	.up0(up0),
	.up1(up1),
	.switch(t_switch)
);

blink U7(
	.out0(t_out0),
	.out1(t_out1),
	.out2(t_out2),
	.out3(t_out3),
	.clk(cnt[23]),
	.rst_n(rst_n),
	.in0(blink0),
	.in1(blink1),
	.in2(blink2),
	.in3(blink3),
	.blink(set)
);

scan_mux U8(
	.scan0(scan_in0),
	.scan1(scan_in1),
	.scan2(scan_in2),
	.scan3(scan_in3),
	.mode(mode),
	.t_out0(t_out0),
	.t_out1(t_out1),
	.t_out2(t_out2),
	.t_out3(t_out3),
	.s_out0(s_out0),
	.s_out1(s_out1),
	.s_out2(s_out2),
	.s_out3(s_out3)
);

scan_ctl U9(
	.ftsd_ctl(ftsd_ctl),
	.ftsd_in(bcd),
	.in0(scan_in0),
	.in1(scan_in1),
	.in2(scan_in2),
	.in3(scan_in3),
	.ftsd_ctl_en(cnt[15:14])
);

bcd2ftsegdec U10(
	.display(ftseg),
	.bcd(bcd)
);

endmodule
