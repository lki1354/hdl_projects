/*!
 *  \file debounce.sv
 *  \brief decode a 4bit BCD input for a seven segment display
 *  \author Lukas Kiechle
 *  \date 2016-12-16 create date
 *  $Revision: 0.9$
*/
/*
	 seven segment
		    a
		  +----+
		 +      +
		 |      |
		f|      |b
		 +  g   +
		  +----+
		 +      +
		 |      |
		e|      |c
		 +      +
		  +----+
		    d
*/
module sevenseg_decoder (
	input	logic	[3:0]		bcd,
	output	logic	[6:0]		sevenseg,
	output	logic	[6:0]		sevenseg_n
);

	always_comb begin
		case (bcd)
			4'd0:	sevenseg = 7'b011_1111; // no 'begin' 'end' needed for one statement
			4'd1:	sevenseg = 7'b000_0110;
			4'd2:	sevenseg = 7'b101_1011;
			4'd3:	sevenseg = 7'b100_1111;
			4'd4:	sevenseg = 7'b110_0110;
			4'd5:	sevenseg = 7'b110_1101;
			4'd6:	sevenseg = 7'b111_1101;
			4'd7:	sevenseg = 7'b000_0111;
			4'd8:	sevenseg = 7'b111_1111;
			4'd9:	sevenseg = 7'b110_1111;
			default:sevenseg = 7'b000_0000;
		endcase
	end

  assign sevenseg_n = ~sevenseg;

endmodule
