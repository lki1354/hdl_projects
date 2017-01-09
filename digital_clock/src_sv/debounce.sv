/*!
 *  \file debounce.sv
 *  \brief a debouncer for button inputs
 *  \author kil
 *  \date 2016-12-16 create date
 *  $Revision: 0.9$
*/

module debounce(
	input	logic		rst_n,
	input	logic		clk,
	input	logic		button,
	output	logic		valid_ff, // high as long as button is pressed
	output	logic		valid_pulse  // only high for one clock periode
);

parameter logic[7:0] count_start = '1;

logic[7:0] counter;	 // counter for debouncing

always_ff @ (negedge rst_n or posedge clk) begin
	if (!rst_n) begin
		counter <= count_start;								// async reset to all ones
		valid_ff <= 1'b0;							// valid_ff is low after reset
	end
	else if ( (button == 1'b0) && (counter > 0) ) begin	// button is pressed
		counter <= counter - 1'b1;					// decrement if not zero
		valid_ff <= 1'b0;
	end
	else if ( (button == 1'b0) && (counter == 1'b0) ) begin
		counter <= '0;								// keep counter at zero when button is pressed
		valid_ff <= 1'b1;							// set valid_ff
	end
	else if (button == 1'b1) begin						// button is released
		counter <= count_start;								// reset counter
		valid_ff <= 1'b0;
	end
end

logic valid_ff2;

always_ff @ (negedge rst_n or posedge clk) begin
	if (!rst_n) begin
		valid_ff2 <= 1'b0;
	end
	else begin
		valid_ff2 <= valid_ff;
	end
end

assign valid_pulse = ( (valid_ff == 1'b1) && (valid_ff2 == 1'b0) );

endmodule
