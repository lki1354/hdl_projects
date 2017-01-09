// ----------------------------
// Purpose	check right behavior of debounce module
// Author	kil
// Version	v0, 08.01.2017
// ----------------------------


module tb_debounce();

	logic		rst_n;
    logic		clk;
    logic		button;
    logic		valid_ff;
    logic		valid_pulse;

	debounce	dut(.*);

	logic run_sim = 1'b1;
	string action;

	initial begin : clk_gen
		clk = 1'b0;
		while (run_sim) begin
			#10ns;
			clk = ~ clk;
		end
	end

	initial begin : test_pattern
		$display("########## tb_debounce start ##############");
		// --- INIT ---
		action = "init";
		$display("\t%s",action);
		rst_n 	= 1'b0;
		button 		= 1'b1;

		#90ns;
		// --- POR ---
		action = "por";
		$display("\t%s",action);
		rst_n = 1'b1;

		#1us;
		// --- press is too short ---
		action = "short press";
		button = 1'b0;
		#1us;
		button = 1'b1;

		#5us
		// --- press is long ---
		action = "long press";
		button = 1'b0;
    @(posedge valid_pulse);
		#1us;
    if (valid_ff != 1'b1) begin
      $display("########### :-( debounce test faild, no rising edge on output!");
    end
    else begin
      $display("########### :-) debounce test passed");
    end

    button = 1'b1;


		#1us;
		// --- STOP ---
		action = "stop";
		$display("\t%s",action);
		run_sim = 1'b0;
	end

endmodule
