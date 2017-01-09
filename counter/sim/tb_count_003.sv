// ----------------------------
// Aufgabe 1 – Kombinatorische Logik Testbench
// Module	tb_count_003
// Verivication of the lut_1596 module
// Author	kil
// Version	v0, 11.12.2016
// ----------------------------

`define TOP 4

module tb_dut ();

  // signals for the device under test
  logic rst_n = 1;
  logic clk5M = 0;
  logic [`TOP:0] data_in = '0;
  logic load = 0;
  logic updn = 0;
  logic en =0;

  logic [`TOP:0] cnt;
  logic co;

  // signals for the testbench
  int errors=0;

  // create dut with the to tested module
  count_003 #(.TOP_BIT(`TOP)) dut (        //#(.TOP_BIT(10)) (
    .rst_n(rst_n),
    .clk(clk5M),
    .data_in(data_in),
    .load(load),
    .updn(updn),
    .en(en),
    .cnt(cnt),
    .co(co)
  );

// clock simulation 5MHz
  logic run_sim = 1'b1;

	initial begin : clk_gen	//5MHz
		clk5M = 1'b0;
		while (run_sim) begin
			#100ns;
			clk5M = ~ clk5M;
		end
	end
  // start test run
  initial begin
    $display("########## Start test! ##########");
    #400ns;
    rst_n = 1'b0;
    #100ns;
    rst_n = 1'b1;
    if (cnt != 0) begin
      errors = errors + 1;
      $display ("Failure after reset! output cnt=0b%b",cnt);
    end

    #100ns;
    updn = 1'b0;
    en = 1'b1;
    #400ns;
    if (cnt != 2) begin
      errors = errors + 1;
      $display ("Failure after count up! output cnt=0b%b",cnt);
    end

    updn = 1'b1;
    #200ns;
    if (cnt != 1) begin
      errors = errors + 1;
      $display ("Failure after count down! output cnt=0b%b",cnt);
    end

    en = 1'b0;
    #400ns;
    if (cnt != 1) begin
      errors = errors + 1;
      $display ("Failure after disable counter! output cnt=0b%b",cnt);
    end

    #200ns;

    data_in = 4'b1111;
    load = 1'b1;
    #200ns;
    load = 1'b0;
    data_in = '0;
    if (cnt != 15) begin
      errors = errors + 1;
      $display ("Failure after load counter! output cnt=0b%b",cnt);
    end

    updn = 1'b0;
    en = 1'b1;
    //wait until posedge co
    @(posedge co)
    if (cnt != '0) begin
      errors = errors + 1;
      $display ("Failure after reach max value! output cnt=0b%b",cnt);
    end

    #200ns;
    if (errors==0) begin
      $display("\t:-) Test run PASSED :-)");
    end else begin
      $display("\t:-( Test run FAILED with %d errors :-(",errors);
    end
    run_sim = 1'b0;
    $display("########## End test! ##########");
  end
endmodule // tb_dut
