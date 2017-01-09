// ----------------------------
// Purpose	check right behavior of pulse_generator module
// Author	kil
// Version	v0, 08.01.2017
// ----------------------------


module tb();
	logic	 rst_n;
	logic	 clk;
	logic	 input_signal;
	logic  pulse;


	pulse_generator dut(.*);

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
		$display("########## test pulse_generator start ##############");
		// --- INIT ---
		action = "init";
		$display("\t%s",action);
		rst_n 	= 1'b0;
		input_signal 		= 1'b0;

		#90ns;
		// --- POR ---
		action = "por";
		$display("\t%s",action);
		rst_n = 1'b1;

		#1us;
		// --- press is short ---
		action = "short press";
		input_signal = 1'b1;
    @(posedge pulse);
    if (pulse == 1'b1) begin
      $display("########### :-) high test passed");
    end
    else begin
      $display("########### :-( high test failed!");
    end
    #30ns
    if (pulse == 1'b0) begin
      $display("########### :-) low test passed");
    end
    else begin
      $display("########### :-( low test failed!");
    end
		#5us
    input_signal = 1'b0;

		#1us;
		// --- STOP ---
		action = "stop";
		$display("\t%s",action);
		run_sim = 1'b0;
	end

endmodule
