/*!
 *  \file key_long_short.sv
 *  \brief debounce the input button and decide between long press and short press
 *  \author kil
 *  \date 2016-12-16 create date
 *  $Revision: 0.9$
*/

module key_long_short (
	input	logic		rst_n,
	input	logic		clk,
	input	logic		button,
	output	logic		key_press_short,
	output	logic		key_press_long
);

parameter logic[32:0] long_press_count = 25000000; //8'b00001111;

logic		valid_ff_s;
logic		valid_pulse_s;

logic valid_ff2;
logic valid_ff3;

logic short;
logic short_store;
logic long;

logic[32:0] counter = long_press_count;		// counter to debounce

debounce #( .count_start(255) ) db_short(
	.rst_n (rst_n),
	.clk(clk),
	.button(button),
	.valid_ff(valid_ff_s),
	.valid_pulse(valid_pulse_s)
);

always_ff @ (negedge rst_n or posedge clk) begin
	if (!rst_n) begin
		short <= 1'b0;
		short_store <= 1'b0;
		long <= 1'b0;
		counter = long_press_count;
	end
	else begin
		if (valid_pulse_s) begin
			short_store <= 1'b1;
		end
	  if ( (valid_ff_s) && (counter > 0) ) begin	// button is pressed
			counter <= counter - 1'b1;
		end
		else if (valid_ff_s && counter == 1'b0) begin
				short_store <= 1'b0;
				long <= 1'b1;
		end
		else if(button==1'b1)begin
			if (valid_ff2) begin
				short_store <= 1'b0;
				short <= 1'b0;
			end
			else begin
				short <= short_store;
			end
			long <=1'b0;
			counter <= long_press_count;
		end
	end
end

always_ff @ (negedge rst_n or posedge clk) begin
	if (!rst_n) begin
		valid_ff2 <= 1'b0;
	end
	else begin
		valid_ff2 <= short;
	end
end

always_ff @ (negedge rst_n or posedge clk) begin
	if (!rst_n) begin
		valid_ff3 <= 1'b0;
	end
	else begin
		valid_ff3 <= long;
	end
end

assign key_press_short = ( (short == 1'b1) && (valid_ff2 == 1'b0) );
assign key_press_long = ( (long == 1'b1) && (valid_ff3 == 1'b0) );

endmodule
