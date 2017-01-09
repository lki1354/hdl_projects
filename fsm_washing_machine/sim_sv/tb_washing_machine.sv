/* -----------------------------------------
-- Author	kil
-- -----------------------------------------*/


module tb; 	

// (1) create wiring for DUT
	 logic		start;
	logic		full;
	logic		hot;
	logic		clean;
	logic 	rst_n;
	logic 	clk;
	 logic	heater;
	 logic	valve;
	 
	 logic	motor;
	 logic	pump;
	 logic 	door_lock; //no , here

// (2) instatiate the DUT
	washing_machine	dut( 
		//.dut name	(tb_name)
		// .bcd	(bcd),  // example 
		.* // is to implement the connection with the same name
	);
	logic run_sim = 0'b1;
	
// (3) create stimuli
initial begin : clk_gen
	clk=  1'b0;
	
	while (run_sim) begin
		# 10ns; //wait for ....
		clk = ~clk;
	end
	# 100ns; //wait for .
end

initial begin :rtl
	start = 0;
	run_sim = 0'b1;
	# 100ns; //wait for ....
	start = 1;
	# 50ns; //wait for ....
	start = 0;
	# 100ns; //wait for .
	full = 1;
	# 50ns;
	full = 0;
	# 100ns; //wait for ....
	hot = 1;
	# 50ns; //wait for ....
	hot = 0;
	# 100ns; //wait for .
	clean = 1;
	# 50ns;
	clean = 0;
end

endmodule