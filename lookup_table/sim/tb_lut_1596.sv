// ----------------------------
// Aufgabe 1 – Kombinatorische Logik Testbench
// Module	tb_lut_1596
// Verivication of the lut_1596 module
// Author	kil
// Version	v0, 11.12.2016
// ----------------------------

module tb_dut ();
  // signals for the device under test
  logic [3:0] x = '0;
  logic y;

  // signals for the testbench
  int errors=0;

  // create dut with the to tested module
  lut_1596 dut (.*);

  // start test run
  initial begin
    $display("########## Start test! ##########");
    # 100ns;
      do begin
        if (x == 4'b0100) begin
          if (y != 1'b1) begin
            errors = errors + 1;
            $display ("Failure at input x=0b%b| y=0b%b",x,y);
          end
        end else if (x == 4'b1000) begin
          if (y != 1'b1) begin
            errors = errors + 1;
            $display ("Failure at input x=0b%b| y=0b%b",x,y);
          end
        end else if (x == 4'b1010) begin
          if (y != 1'b1) begin
            errors = errors + 1;
            $display ("Failure at input x=0b%b| y=0b%b",x,y);
          end
        end else begin
          if (y != 1'b0) begin
            errors = errors + 1;
            $display ("Failure at input x=0b%b| y=0b%b",x,y);
          end
        end
        x = x + 4'b0001;
        # 100ns;
      end while (x != 4'b0000);

      if (errors==0) begin
        $display("Tesrun PASSED");
      end else begin
        $display("Test run FAILED with %d errors",errors);
      end

      $display("########## End test! ##########");
    end
endmodule // tb_dut
