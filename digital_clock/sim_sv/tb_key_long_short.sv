// ----------------------------
// Purpose	check right behavior of key_long_short module
// Author	kil
// Version	v0, 08.01.2017
// ----------------------------


module tb();

	logic		rst_n;
    logic		clk;
    logic		button;
    logic		key_press_short;
    logic		key_press_long;

	key_long_short #(.long_press_count(500) )	dut(.*);

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
		$display("########## test key_long_short start ##############");
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
		// --- press is short ---
		action = "short press";
		button = 1'b0;
		#6us;
		button = 1'b1;
    @(posedge key_press_short);
    if (key_press_short == 1'b1) begin
      $display("########### :-) short press test passed");
    end

		#5us
		// --- press is long ---
		action = "long press";
		button = 1'b0;
		//#20us;
    @(posedge key_press_long);
    if (key_press_long == 1'b1) begin
      $display("########### :-) long press test passed");
    end

    button = 1'b1;


		#1us;
		// --- STOP ---
		action = "stop";
		$display("\t%s",action);
		run_sim = 1'b0;
	end

endmodule
