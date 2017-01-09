/* -----------------------------------------
-- Purpuse verification of clock_divider module
-- Author	Lukas Kiechle
-- Version	v00, 07.01.2017
-- -----------------------------------------*/


module tb;

logic clk;
logic rst_n;
logic enable;
logic clk_out;

	clock_divider #(.count_start(6)) dut(
		.*
	);
logic run_sim = 1'b1;
logic failed = 1'b0;

initial begin : clk_gen
	clk=  1'b0;

	while (run_sim) begin
		# 20ns;
		clk = ~clk;
	end
	# 100ns;
end

initial begin :rtl
	$display("########### start test run ####################");
	# 100ns;
	rst_n = 0;
	# 100ns;
	rst_n = 1;
	# 100ns;
	if( clk_out != 1'b0 )begin
		$display("Test 1 failed: clk_out = 0x%h",clk_out);
		failed = 1'b1;
	end
	enable = 1'b1;
	#1us
  if( clk_out != 1'b1 )begin
		$display("Test 2 failed: clk_out = 0x%h",clk_out);
		failed = 1'b1;
	end

	if( failed==1'b1 )begin
		$display("########### :-( Test run failed!");
	end
	else if( failed==1'b0 )begin
		$display("########### :-) Test run was successful!");
	end
	run_sim = 1'b0;

end

endmodule
