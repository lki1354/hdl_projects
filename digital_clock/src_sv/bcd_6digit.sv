/*!
 *  \file bcd_6digit.sv
 *  \brief 6 digit BCD counter with overflow at 23:59:99 for a 24 hour clock implementation
 *  \author Lukas Kiechle
 *  \date 2016-12-16 create date
 *  $Revision: 0.9$
*/

module bcd_6digit (

	input	logic		rst_n,
	input	logic		clk,
	input	logic		cnt_en,		// count one up if it is high during rising clock on "clk"
  input logic   update_H1,
  input logic   update_H2,
  input logic   update_M1,
  input logic   update_M2,
  input logic   update_S1,
  input logic   update_S2,
  input logic   update_count,

	output	logic [3:0]	bcd_H1,		// BCD digit hour group of ten (0-2)
	output	logic [3:0]	bcd_H2,		// BCD digit hour unit position (0-9)
	output	logic [3:0]	bcd_M1,		// BCD digit minute group of ten (0-5)
	output	logic [3:0]	bcd_M2,		// BCD digit minute unit position (0-9
	output	logic [3:0]	bcd_S1,		// BCD digit second group of ten (0-5)
	output	logic [3:0]	bcd_S2		// BCD digit second unit position (0-9)
);

	logic	co0;		// carry out of second unit position
	logic	co1;		// carry out of second group of ten
	logic	co2;		// carry out of minute unit position
	logic	co3;		// carry out of minute group of ten
	logic	co4;		// carry out of hour unit position
	logic	co5;		// carry out of hour group of ten

	logic	cnt_en0;	// count of second unit position
	logic	cnt_en1;  // count of second group of ten
	logic	cnt_en2;  // carry of minute unit position
	logic	cnt_en3;  // carry of minute group of ten
	logic	cnt_en4;  // carry of hour unit position
	logic	cnt_en5;	// carry of hour group of ten

	logic	cnt_en_all;	// enable counting

	logic reset_counter;

	bcdcnt #( .END_COUNT(9) )	bcdcnt_S1
	(
		.rst_n			(reset_counter),
		.clk			(clk),
		.cnt_en			(cnt_en0),
		.bcd			(bcd_S1),
		.co				(co0)
	);

	bcdcnt #( .END_COUNT(5) )	bcdcnt_S2
	(
		.rst_n			(reset_counter),
		.clk			(clk),
		.cnt_en			(cnt_en1),
		.bcd			(bcd_S2),
		.co				(co1)
	);

	bcdcnt #( .END_COUNT(9) )	bcdcnt_M1
	(
		.rst_n			(reset_counter),
		.clk			(clk),
		.cnt_en			(cnt_en2),
		.bcd			(bcd_M1),
		.co				(co2)
	);

	bcdcnt #( .END_COUNT(5) )	bcdcnt_M2
	(
		.rst_n			(reset_counter),
		.clk			(clk),
		.cnt_en			(cnt_en3),
		.bcd			(bcd_M2),
		.co				(co3)
	);

	bcdcnt #( .END_COUNT(9) ) bcdcnt_H1
	(
		.rst_n			(reset_counter),
		.clk			(clk),
		.cnt_en			(cnt_en4),
		.bcd			(bcd_H1),
		.co				(co4)
	);

	bcdcnt #( .END_COUNT(2) )	bcdcnt_H2
	(
		.rst_n			(reset_counter),
		.clk			(clk),
		.cnt_en			(cnt_en5),
		.bcd			(bcd_H2),
		.co				(co5)
	);
  // if one counter has do be change manually, all counters are stoped
  assign cnt_en_all = (update_H1 || update_H2 || update_M1 || update_M2 || update_S1 || update_S2) ? 1'b0 : cnt_en;

  // connects the right counter which has to be updated manually and handles overflow of each counter
  assign cnt_en0 = (update_S1) ? update_count : cnt_en_all;
	assign cnt_en1 = (update_S2) ? update_count : cnt_en_all && co0;
	assign cnt_en2 = (update_M1) ? update_count : cnt_en_all && co0 && co1;
	assign cnt_en3 = (update_M2) ? update_count : cnt_en_all && co0 && co1 && co2;
	assign cnt_en4 = (update_H1) ? update_count : cnt_en_all && co0 && co1 && co2 && co3;
	assign cnt_en5 = (update_H2) ? update_count : cnt_en_all && co0 && co1 && co2 && co3 && co4;

  // handles reach eand of day from the 24 hour counter
  always_comb begin
  	if (bcd_H1 >= 4'd4 && bcd_H2 >=4'd2 ) begin
  		reset_counter = 1'b0;
  	end
  	else begin
  		reset_counter = rst_n;
  	end
  end

endmodule
