/*!
 *  \file bcdcnt.sv
 *  \brief standart 4 digit BCD ( Binary Coded Decimal ) counter
 *  \author Lukas Kiechle
 *  \date 2016-12-16 create date
 *  $Revision: 0.9$
*/

module bcdcnt #(parameter END_COUNT=9)(
	input	logic		rst_n,
	input	logic		clk,
	input	logic		cnt_en,		// counter enable

	output	logic [3:0]	bcd,		// count varialbe
	output	logic		co			// Carry out --> 	shall indicate start count new from 0
);

always_ff @ (negedge rst_n or posedge clk) begin : bcd_counter
	if (!rst_n) begin
		bcd <= 4'd0;
  end	else if (cnt_en && (bcd < END_COUNT ) ) begin // count one up if enable is high
		bcd <= bcd + 4'b0001;
	end	else if (cnt_en && (bcd >= END_COUNT) ) begin  // reset counter value if top is reached
		bcd <= 4'd0;
	end

end

// rise to high if end value ist reached
assign co = (bcd == END_COUNT);


endmodule
