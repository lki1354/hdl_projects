// ----------------------------
// Aufgabe 1 – Kombinatorische Logik Testbench
// Module	tb_fsm_door_003
// Verivication of the tb_fsm_door_003 module
// Author	kil
// Version	v0, 11.12.2016
// ----------------------------

module tb_dut ();
  // signals for the device under test
  logic rst_n = 1;
  logic clk2M = 0;

  logic key_up= 0;
  logic key_down= 0;
  logic sense_up=0;
  logic sense_down=0;

  logic ml;
  logic mr;
  logic light_red;
  logic light_green;
  logic [2:0] state;

  // signals for the testbench
  int errors=0;

  // create dut with the to tested module
  fsm_door_003 dut (        //#(.TOP_BIT(10)) (
    .rst_n(rst_n),
    .clk(clk2M),
    .key_up(key_up),
    .key_down(key_down),
    .sense_up(sense_up),
    .sense_down(sense_down),
    .ml(ml),
    .mr(mr),
    .light_red(light_red),
    .light_green(light_green),
    .db_state(state)
  );

// clock simulation 5MHz
  logic run_sim = 1'b1;

	initial begin : clk_gen	//2MHz
		clk2M = 1'b0;
		while (run_sim) begin
			#250ns;	
			clk2M = ~ clk2M;
		end
	end
  // start test run
  initial begin : tb_run
    $display("########## Start test! ##########");
    #1us;

//start reset Test
    rst_n = 1'b0;
    sense_down = 1'b1;
    #1us;
    rst_n = 1'b1;
    if (ml != 0 && mr != 0 && light_red!=1'b1 &&light_green!=1'b0 && state!=3'b001) begin
      errors = errors + 1;
      $display ("Failure after reset! state=0b%b",state);
    end
//end reset Test

//start press key_up
    #1us;
    key_up = 1'b1;
    #1us;
    key_up = 1'b0;
    sense_down = 1'b0;
    #4us;
    if (mr != 1'b1 && ml!=1'b0 && light_red!=1'b1 &&light_green!=1'b0 && state!=3'b011) begin
      errors = errors + 1;
      $display ("Failure after key up! state=0b%b",state);
    end
//end press key_up

//start reach sense_up
    #1us;
    sense_up = 1'b1;
    #2us;
    if (mr != 1'b0 || ml!=1'b0 || light_red!=1'b0 || light_green!=1'b1 || state!=3'b010) begin
      errors = errors + 1;
      $display ("Failure after reach sense_up! state=0b%b",state);
    end
//end reach sense_up

//start press key_down
    #1us;
    key_down = 1'b1;
    #1us;
    key_down = 1'b0;
    sense_up = 1'b0;
    #4us;
    if (mr != 1'b0 || ml!=1'b1 || light_red!=1'b1 || light_green!=1'b0 || state!=3'b100) begin
      errors = errors + 1;
      $display ("Failure after key down! state=0b%b",state);
    end
//end press key_down

//start reach sense_down
    #1us;
    sense_down = 1'b1;
    #2us;
    if (mr != 1'b0 || ml!=1'b0 || light_red!=1'b1  || light_green!=1'b0 || state!=3'b001) begin
      errors = errors + 1;
      $display ("Failure after reach sense_down! state=0b%b",state);
    end
//end reach sense_down

//start press key_up and key_down
    #1us;
    key_up = 1'b1;
    #1us;
    sense_down = 1'b0;
    #1us;
    key_down = 1'b1;
    #1us;
    key_down = 1'b0;
    key_up = 1'b0;
    #2us;
    if (mr != 1'b0 || ml!=1'b0 || light_red!=1'b1 || light_green!=1'b0 || state!=3'b000) begin
      errors = errors + 1;
      $display ("Failure after key up and key down are pressed! state=0b%b",state);
    end
//end press key_up

//start press key_down and later key up during down state
    #1us;
    key_down = 1'b1;
    #1us;
    key_down = 1'b0;
    sense_up = 1'b0;
    #2us;
    if (mr != 1'b0 && ml!=1'b1 && light_red!=1'b1 || light_green!=1'b0 || state!=3'b100) begin
      errors = errors + 1;
      $display ("Failure after key down second! state=0b%b",state);
    end

    #1us;
    key_up = 1'b1;
    #1us;
    key_up = 1'b0;
    sense_down = 1'b0;
    #4us;
    if (mr != 1'b1 || ml!=1'b0 || light_red!=1'b1 || light_green!=1'b0 || state!=3'b011) begin
      errors = errors + 1;
      $display ("Failure after key up second! state=0b%b",state);
    end

    #1us;
    sense_up = 1'b1;
    #2us;
    if (mr != 1'b0 || ml!=1'b0 || light_red!=1'b0 || light_green!=1'b1  || state!=3'b010) begin
      errors = errors + 1;
      $display ("Failure after reach sense_up second! state=0b%b",state);
    end
//end press key_down and later key up during down state




//Test ends print result
    #2us;
    if (errors==0) begin
      $display("\t :-) Test run PASSED  :-) ");
    end else begin
      $display("\t :-( Test run FAILED with %d errors :-(",errors);
    end
    run_sim = 1'b0;
    $display("########## End test! ##########");
  end

endmodule // tb_dut
