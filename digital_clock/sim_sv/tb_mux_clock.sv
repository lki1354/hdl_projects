// ----------------------------
// Purpose	Check mux_clock module
// Author	kil
// Version	v0, 07.01.2017
// ----------------------------

module tb();

  logic   hour_miniute = 1'b0;
  logic   second = 1'b0;
  logic   update_H1= 1'b0;
  logic   update_H2= 1'b0;
  logic   update_M1= 1'b0;
  logic   update_M2= 1'b0;
  logic   update_S1= 1'b0;
  logic   update_S2= 1'b0;
  logic   blink = 1'b0;

	logic [3:0]	bcd_S1 = 4'b0000;
	logic [3:0]	bcd_S2 = 4'b0000;
	logic [3:0]	bcd_M1 = 4'b0000;
	logic [3:0]	bcd_M2 = 4'b0000;
	logic [3:0]	bcd_H1 = 4'b0000;
	logic [3:0]	bcd_H2 = 4'b0000;

	logic [3:0]	bcd0;
	logic [3:0]	bcd1;
	logic [3:0]	bcd2;
	logic [3:0]	bcd3;

	mux_clock	dut(.*);

  logic clk = 1'b0;
	logic run_sim = 1'b1;
	string action;

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

    @(negedge clk);
		// --- POR ---
		action = "por";
		$display("\t%s",action);

//start test 1
		@(posedge clk);
    if (bcd0 != 4'b0000 && bcd1 != 4'b0000 && bcd2 != 4'b0000 && bcd3 != 4'b0000) begin
      errors = errors + 1;
      $display ("Failure Test 1: bcd outputs not zero!");
    end
    @(negedge clk);
//end test 1

//start test 2
    bcd_M1 = 4'b0101;
    bcd_M2 = 4'b1010;
    bcd_H1 = 4'b1100;
    bcd_H2 = 4'b0011;
    hour_miniute = 1'b1;
		@(posedge clk);
    if (bcd0 != 4'b0101 && bcd1 != 4'b1010 && bcd2 != 4'b1100 && bcd3 != 4'b0011) begin
      errors = errors + 1;
      $display ("Failure Test 2: bcd outputs has to show hours and minutes!");
    end
    hour_miniute = 1'b0;
    @(negedge clk);
//end test 2

//start test 3
    bcd_M1 = 4'b0101;
    bcd_M2 = 4'b1010;
    bcd_S1 = 4'b1100;
    bcd_S2 = 4'b0011;
    second = 1'b1;
		@(posedge clk);
    if (bcd2 != 4'b0101 && bcd3 != 4'b1010 && bcd0 != 4'b1100 && bcd2 != 4'b0011) begin
      errors = errors + 1;
      $display ("Failure Test 3: bcd outputs has to show minutes and seconds!");
    end
    second = 1'b0;
    @(negedge clk);
//end test 3

//start test 4
    bcd_M1 = 4'b0101;
    bcd_M2 = 4'b1010;
    bcd_H1 = 4'b1100;
    bcd_H2 = 4'b0011;
    update_H1 = 1'b1;
		@(posedge clk);
    if (bcd0 != 4'b0101 && bcd1 != 4'b1010 && bcd2 != 4'b0000 && bcd3 != 4'b0011) begin
      errors = errors + 1;
      $display ("Failure Test 4: bcd output hour 1 has to be zero (update)  !");
    end
    update_H1 = 1'b0;
    @(negedge clk);
//end test 4

//start test 5
    bcd_M1 = 4'b0101;
    bcd_M2 = 4'b1010;
    bcd_H1 = 4'b1100;
    bcd_H2 = 4'b0011;
    update_H2 = 1'b1;
		@(posedge clk);
    if (bcd0 != 4'b0101 && bcd1 != 4'b1010 && bcd2 != 4'b1100 && bcd3 != 4'b0000) begin
      errors = errors + 1;
      $display ("Failure Test 5: bcd output hour 2 has to be zero (update)  !");
    end
    update_H2 = 1'b0;
    @(negedge clk);
//end test 5

//start test 6
    bcd_M1 = 4'b0101;
    bcd_M2 = 4'b1010;
    bcd_H1 = 4'b1100;
    bcd_H2 = 4'b0011;
    update_M1 = 1'b1;
		@(posedge clk);
    if (bcd0 != 4'b0000 && bcd1 != 4'b1010 && bcd2 != 4'b1100 && bcd3 != 4'b0011) begin
      errors = errors + 1;
      $display ("Failure Test 6: bcd output minute 1 has to be zero (update)  !");
    end
    update_M1 = 1'b0;
    @(negedge clk);
//end test 6

//start test 7
    bcd_M1 = 4'b0101;
    bcd_M2 = 4'b1010;
    bcd_H1 = 4'b1100;
    bcd_H2 = 4'b0011;
    update_M2 = 1'b1;
		@(posedge clk);
    if (bcd0 != 4'b0101 && bcd1 != 4'b0000 && bcd2 != 4'b1100 && bcd3 != 4'b0011) begin
      errors = errors + 1;
      $display ("Failure Test 7: bcd output minute 2 has to be zero (update)  !");
    end
    update_M2 = 1'b0;
    @(negedge clk);
//end test 7

//start test 8
    bcd_M1 = 4'b0101;
    bcd_M2 = 4'b1010;
    bcd_S1 = 4'b1100;
    bcd_S2 = 4'b0011;
    update_S1 = 1'b1;
		@(posedge clk);
    if (bcd2 != 4'b0101 && bcd3 != 4'b1010 && bcd0 != 4'b0000 && bcd2 != 4'b0011) begin
      errors = errors + 1;
      $display ("Failure Test 8: bcd output second 1 has to be zero (update) !");
    end
    update_S1 = 1'b0;
    @(negedge clk);
//end test 8

//start test 9
    bcd_M1 = 4'b0101;
    bcd_M2 = 4'b1010;
    bcd_S1 = 4'b1100;
    bcd_S2 = 4'b0011;
    update_S2 = 1'b1;
		@(posedge clk);
    if (bcd2 != 4'b0101 && bcd3 != 4'b1010 && bcd0 != 4'b1100 && bcd2 != 4'b0000) begin
      errors = errors + 1;
      $display ("Failure Test 9: bcd output second 2 has to be zero (update) !");
    end
    update_S2 = 1'b0;
    @(negedge clk);
//end test 9


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
