/* -----------------------------------------
-- Purpuse	Check the correct behavior of the clock state machine
-- Author	kil
-- Version	v00, 07.01.2017
-- -----------------------------------------*/


module tb;

	logic clk;
	logic rst_n;
	logic key_short;
	logic key_long;
	logic	HHMM_view;
	logic	MMSS_view;
	logic	S_H1;
	logic	S_H2;
	logic S_M1;
	logic S_M2;
	logic	S_S1;
	logic	S_S2;
	logic[2:0] state;
	logic failed=0'b0;

	clock_sm dut(
		.*
	);
	logic run_sim = 1'b1;

initial begin : clk_gen
	clk=  1'b0;

	while (run_sim) begin
		# 20ns;
		clk = ~clk;
	end
	# 100ns;
end

initial begin :rtl
	$display("########### Start Test for clock state machine module ###################");
	run_sim = 1'b1;
	# 100ns;
	rst_n = 0;
	# 100ns;
	rst_n = 1;
	# 100ns;
	if( state != 3'h0 )begin
		$display("Test 1 failed: state = 0x%h",state);
		failed = 0'b1;
	end
	if( HHMM_view!==1 && MMSS_view!==0 && S_H1!==0 && S_H2!==0 && S_M1!==0 && S_M2!==0 && S_S1!==0 && S_S2!==0 )begin
		failed = 0'b1;
	end

	key_long = 0'b1;
	# 40ns;
	key_long = 0'b0;
	# 100ns;
	if( state != 3'h2 )begin
		$display("Test 2 failed: state = %d",state);
		failed = 0'b1;
	end
	if( HHMM_view!==0 && MMSS_view!==0 && S_H1!==1 && S_H2!==0 && S_M1!==0 && S_M2!==0 && S_S1!==0 && S_S2!==0 )begin
		failed = 0'b1;
	end

	key_short = 0'b1;
	# 40ns;
	key_short = 0'b0;
	# 100ns;
	if( state != 3'h3 )begin
		$display("Test 3 failed: state = %d",state);
		failed = 0'b1;
	end
	if( HHMM_view!==0 && MMSS_view!==0 && S_H1!==0 && S_H2!==1 && S_M1!==0 && S_M2!==0 && S_S1!==0 && S_S2!==0 )begin
		failed = 0'b1;
	end

	key_short = 0'b1;
	# 40ns;
	key_short = 0'b0;
	# 100ns;
	if( state != 3'h4 )begin
		$display("Test 4 failed: state = %d",state);
		failed = 0'b1;
	end
	if( HHMM_view!==0 && MMSS_view!==0 && S_H1!==0 && S_H2!==0 && S_M1!==1 && S_M2!==0 && S_S1!==0 && S_S2!==0 )begin
		failed = 0'b1;
	end

	key_short = 0'b1;
	# 40ns;
	key_short = 0'b0;
	# 100ns;
	if( state != 3'h5 )begin
		$display("Test 5 failed: state = %d",state);
		failed = 0'b1;
	end
	if( HHMM_view!==0 && MMSS_view!==0 && S_H1!==0 && S_H2!==0 && S_M1!==0 && S_M2!==1 && S_S1!==0 && S_S2!==0 )begin
		failed = 0'b1;
	end

	key_short = 0'b1;
	# 40ns;
	key_short = 0'b0;
	# 100ns;
	if( state != 3'h6 )begin
		$display("Test 6 failed: state = %d",state);
		failed = 0'b1;
	end
	if( HHMM_view!==0 && MMSS_view!==0 && S_H1!==0 && S_H2!==0 && S_M1!==0 && S_M2!==0 && S_S1!==1 && S_S2!==0 )begin
		failed = 0'b1;
	end

	key_short = 0'b1;
	# 40ns;
	key_short = 0'b0;
	# 100ns;
	if( state != 3'h7 )begin
		$display("Test 7 failed: state = %d",state);
		failed = 0'b1;
	end
	if( HHMM_view!==0 && MMSS_view!==0 && S_H1!==0 && S_H2!==0 && S_M1!==0 && S_M2!==0 && S_S1!==0 && S_S2!==1 )begin
		failed = 0'b1;
	end

	key_short = 0'b1;
	# 40ns;
	key_short = 0'b0;
	# 100ns;
	if( state != 3'h0 )begin
		$display("Test 8 failed: state = %d",state);
		failed = 0'b1;
	end
	if( HHMM_view!==1 && MMSS_view!==0 && S_H1!==0 && S_H2!==0 && S_M1!==0 && S_M2!==0 && S_S1!==0 && S_S2!==0 )begin
		failed = 0'b1;
	end

	key_short = 0'b1;
	# 40ns;
	key_short = 0'b0;
	# 100ns;
	if( state != 3'h1 )begin
		$display("Test 9 failed: state = %h",state);
		failed = 0'b1;
	end
	if( HHMM_view!==0 && MMSS_view!==1 && S_H1!==0 && S_H2!==0 && S_M1!==0 && S_M2!==0 && S_S1!==0 && S_S2!==0 )begin
		failed = 0'b1;
	end

	key_short = 0'b1;
	# 40ns;
	key_short = 0'b0;
	# 100ns;
	if( state != 3'h0 )begin
		$display("Test 10 failed: state = %h",state);
		failed = 0'b1;
	end
	if( HHMM_view!==1 && MMSS_view!==0 && S_H1!==0 && S_H2!==0 && S_M1!==0 && S_M2!==0 && S_S1!==0 && S_S2!==0 )begin
		failed = 0'b1;
	end

	if( failed==0'b1 )begin
		$display("########### :-( Test run failed!");
	end
	else if( failed==0'b0 )begin
		$display("########### :-) Test run was successful!");
	end
	run_sim = 0'b0;

end

endmodule
