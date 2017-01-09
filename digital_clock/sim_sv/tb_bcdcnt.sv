// ----------------------------
// Purpose	check behavior of bcdcnt module
// Author kil
// Version	v0, 07.01.2017
// ----------------------------

module tb_bcdcnt();

	logic		rst_n;
	logic		clk;
	logic		cnt_en;

	logic [3:0]	bcd;
	logic		co;

	bcdcnt	dut(.*);

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
    $display("########## Start test! ##########");
		// --- INIT ---
		action = "init";
		$display("\t%s",action);
		rst_n 	= 1'b0;
		cnt_en 	= 1'b0;

		#90ns;
		// --- POR ---
		action = "por";
		$display("\t%s",action);
		rst_n = 1'b1;

		// --- count up 8 times ---
		action = "count8";
		$display("\t%s",action);
		for (int i = 0; i<8; i++) begin
			@(negedge clk);
			cnt_en = 1'b1;
			@(negedge clk);
			cnt_en = 1'b0;
		end
		if (bcd != 8) begin
			$error("Wrong value of bcd after 8 counts. bcd = %d, should be 8. ", bcd);
		end

		action = "count8-9";
		$display("\t%s",action);
		for (int i = 0; i<1; i++) begin
			@(negedge clk);
			cnt_en = 1'b1;
			@(negedge clk);
			cnt_en = 1'b0;
		end
		if (bcd != 9) begin
			$error("Wrong value of bcd after 8 counts. bcd = %d, should be 8. ", bcd);
		end
		if (co != 1'b1) begin
			$error("co is not set when bcd reaches 9");
		end

		action = "count9-0";
		$display("\t%s",action);
		for (int i = 0; i<1; i++) begin
			@(negedge clk);
			cnt_en = 1'b1;
			@(negedge clk);
			cnt_en = 1'b0;
		end
		if (bcd != 0) begin
			$error("Wrong value of bcd after 8 counts. bcd = %d, should be 8. ", bcd);
		end
		if (co != 1'b0) begin
			$error("co is not reset when bcd reaches 0");
		end


		@(posedge clk);
		@(negedge clk);
		// --- STOP ---
		action = "stop";
		$display("\t%s",action);
		run_sim = 1'b0;
	end


endmodule
