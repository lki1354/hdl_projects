
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module project_clock_C5G(

	//////////// CLOCK //////////
	input 		          		CLOCK_125_p,
	input 		          		CLOCK_50_B5B,
	input 		          		CLOCK_50_B6A,
	input 		          		CLOCK_50_B7A,
	input 		          		CLOCK_50_B8A,

	//////////// LED //////////
	output		     [7:0]		LEDG,
	output		     [9:0]		LEDR,

	//////////// KEY //////////
	input 		          		CPU_RESET_n,
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

	clock_main	top(
	 .rst_n(CPU_RESET_n),
    .clk50m(CLOCK_50_B5B),
    .button_sm(KEY[0]),
    .button_count(KEY[1]),
    .button_sec_enable(SW[0]),
    .state(LEDG[2:0]),
    .seg3(HEX3),
    .seg2(HEX2),
    .seg1(HEX1),
    .seg0(HEX0)
	);



//=======================================================
//  Structural coding
//=======================================================



endmodule
