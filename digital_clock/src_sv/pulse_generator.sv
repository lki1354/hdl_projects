/*!
 *  \file pulse_generator.sv
 *  \brief create a pulse for one working clock periode from a input clock
 *  \author Lukas Kiechle
 *  \date 2016-12-16 create date
 *  $Revision: 0.9$
*/

module pulse_generator(
	input	logic		rst_n,
	input	logic		clk,
	input	logic		input_signal,
	output	logic	pulse
);

logic valid_pulse;

always_ff @ (negedge rst_n or posedge clk) begin
	if (!rst_n) begin
		valid_pulse <= 1'b0;
	end
	else begin
		valid_pulse <= input_signal;
	end
end

assign pulse = ( (input_signal == 1'b1) && (valid_pulse == 1'b0) );


endmodule
