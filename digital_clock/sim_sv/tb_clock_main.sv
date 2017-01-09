/* -----------------------------------------
-- Purpuse	Check the correct behavior of the clock main module
-- Author	Lukas K.
-- Version	v00, 08.01.2017
-- -----------------------------------------*/

module tb_clock_main();

// (1) Create wiring for DUT
logic rst_n;
logic clk50m;
logic button_sm=1'b1;
logic button_count;
logic button_sec_enable;

logic [2:0] state;

logic [6:0] seg3;
logic [6:0] seg2;
logic [6:0] seg1;
logic [6:0] seg0;
// (2) Instantiate the DUT
	clock_main dut(
		.*
	);

	// (3) Stimulate the DUT
		logic run_sim = 1'b1;
		string action;

		initial begin : clk_gen
			clk50m = 1'b0;
			while (run_sim) begin
				#10ns;
				clk50m = ~ clk50m;
			end
		end

		initial begin : test_pattern
			$display("-----------------");
			$display("tb started");
			$display("-----------------");
			// --- INIT ---
			action = "init";
			$display("\t%s",action);
			rst_n 	= 1'b0;
			//cnt_en 	= 1'b0;
			button_sec_enable = 1'b1;

			#90ns;
			// --- POR ---
			action = "por";
			$display("\t%s",action);
			rst_n = 1'b1;
			// --- count up 10000 times ---
			action = "wait 9 sec";
			$display("\t%s",action);
			#9us
			button_sm = 1'b0;
			#9s

			button_sm = 1'b1;
			#60us
			button_sm = 1'b0;
			#6us
			button_sm = 1'b1;
			#6us
			button_sm = 1'b0;
			#3ms
			button_sm = 1'b1;
			#6us
			button_sm = 1'b0;
			#3ms

			//#9s;
			// --- STOP ---
			action = "stop";
			$display("\t%s",action);
			run_sim = 1'b0;
		end

endmodule
