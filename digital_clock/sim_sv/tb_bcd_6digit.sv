// ----------------------------
// Purpose	Check bcd_6digit module
// Author	Lukas Kiechle
// Version	v0, 07.01.2017
// ----------------------------

module tb_bcd_6digit();

	logic		rst_n;
	logic		clk;
	logic		cnt_en;
  logic   update_H1= 1'b0;
  logic   update_H2= 1'b0;
  logic   update_M1= 1'b0;
  logic   update_M2= 1'b0;
  logic   update_S1= 1'b0;
  logic   update_S2= 1'b0;
  logic   update_count= 1'b0;

	logic [3:0]	bcd_S1;
	logic [3:0]	bcd_S2;
	logic [3:0]	bcd_M1;
	logic [3:0]	bcd_M2;
	logic [3:0]	bcd_H1;
	logic [3:0]	bcd_H2;


	bcd_6digit	dut(.*);

// Stimulate the DUT
	logic run_sim = 1'b1;
	string action;
  // signals for the testbench
   int errors=0;

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

		// --- count up 87000 times ---
		action = "count87k";
		$display("\t%s",action);
		for (int i = 0; i<87000; i++) begin
			@(negedge clk);
			cnt_en = 1'b1;
			@(negedge clk);
			cnt_en = 1'b0;
		end

		#1us;

    update_H1 = 1'b1;
    update_count = 1'b1;
		@(posedge clk);
    @(negedge clk);
    if (bcd_H1 != 4'b0001) begin
      errors = errors + 1;
      $display ("Failure after update H1 bcd! output bcd_H1=0b%b",bcd_H1);
    end

    #1us;

		// --- STOP ---
		action = "stop";
		$display("\t%s",action);
		run_sim = 1'b0;

    if (errors==0) begin
      $display("########## :-) Test run PASSED :-)");
    end else begin
      $display("########## :-( Test run FAILED with %d errors :-(",errors);
    end

  end


endmodule
