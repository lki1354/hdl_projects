/*!
 *  \file clock_divider.sv
 *  \brief devide a input clock with a defined top value for a internal counter
 *  \author Lukas Kiechle
 *  \date 2016-12-16 create date
 *  $Revision: 0.9$
*/

module clock_divider (
	input logic clk,
	input logic rst_n,
	input logic enable,
	output logic clk_out
);

//calculate devider : count = time {new clock pulse [s]]} * frequenzy {input clock [Hz]}
parameter logic[31:0] count_start = 25000000;

logic [31:0] counter;

always_ff @ (negedge rst_n or posedge clk) begin
	if (!rst_n) begin
		counter <= count_start;
		clk_out <= 1'b0;
	end
	else begin
		if ( !enable) begin
			clk_out	<= 1'b0;
		end
		else if (counter > 0) begin
			counter <= counter - 1'b1;
		end
		else begin
			counter <= count_start;
			clk_out = !clk_out;
		end
	end
end

endmodule
