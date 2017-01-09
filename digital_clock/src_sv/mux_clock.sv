/*!
 *  \file mux_clock.sv
 *  \brief mux for the right view BCD signals on the view
 *  \author kil
 *  \date 2016-12-16 create date
 *  $Revision: 0.9$
*/

module mux_clock(
	input	logic		hour_miniute,
	input	logic		second,
	input	logic		update_H1,
	input	logic		update_H2,
	input	logic		update_M1,
	input	logic		update_M2,
	input	logic		update_S1,
	input	logic		update_S2,
  input logic   blink,
	input	logic [3:0]	bcd_H1,
	input	logic [3:0]	bcd_H2,

	input logic [3:0]	bcd_M1,
	input	logic [3:0]	bcd_M2,

	input	logic [3:0]	bcd_S1,
	input	logic [3:0]	bcd_S2,

	output	logic [3:0]	bcd0,
	output	logic [3:0]	bcd1,
	output	logic [3:0]	bcd2,
	output	logic [3:0]	bcd3

);

always_comb begin
		if (hour_miniute==1'b1) begin
			bcd3 = bcd_H2;
			bcd2 = bcd_H1;
			bcd1 = bcd_M2;
			bcd0 = bcd_M1;
		end else if (second==1'b1) begin
			bcd3 = bcd_M2;//4'b1111;
			bcd2 = bcd_M1;//4'b1111;
			bcd1 = bcd_S2;
			bcd0 = bcd_S1;
		end else if (update_H1==1'b1) begin
			bcd3 = bcd_H2;
			bcd2 = blink ? bcd_H1 : 4'b1111;
			bcd1 = bcd_M2;
			bcd0 = bcd_M1;
		end else if (update_H2==1'b1) begin
			bcd3 = blink ? bcd_H2 : 4'b1111;
			bcd2 = bcd_H1;
			bcd1 = bcd_M2;
			bcd0 = bcd_M1;
		end else if (update_M1==1'b1) begin
			bcd3 = bcd_H2;
			bcd2 = bcd_H1;
			bcd1 = bcd_M2;
			bcd0 = blink ? bcd_M1 : 4'b1111;
		end else if (update_M2==1'b1) begin
			bcd3 = bcd_H2;
			bcd2 = bcd_H1;
			bcd1 = blink ? bcd_M2 : 4'b1111;
			bcd0 = bcd_M1;
		end else if (update_S1==1'b1) begin
			bcd3 = bcd_M2;
			bcd2 = bcd_M1;
			bcd1 = bcd_S2;
			bcd0 = blink ? bcd_S2 : 4'b1111;
		end else if (update_S2==1'b1) begin
			bcd3 = bcd_M2;
			bcd2 = bcd_M1;
			bcd1 = blink ? bcd_S2 : 4'b1111;
			bcd0 = bcd_S1;
		end else begin
			bcd3 = 4'b0000;
			bcd2 = 4'b0000;
			bcd1 = 4'b0000;
			bcd0 = 4'b0000;
		end
end

endmodule
