// ----------------------------
// Purpose	check right behavior of sevenseg_decoder module
// Author	kil
// Version	v0, 08.01.2017
// ----------------------------

module tb_sevenseg_decoder();

	logic	[3:0]		bcd;
	logic	[6:0]		sevenseg;
	logic	[6:0]		sevenseg_n;

  int errors = 0;

	sevenseg_decoder	dut(
		.*
	);

	initial begin
  $display("########## Start test! ##########");
  # 100ns;
  bcd = 4'b0000;
  # 100ns;
  if (sevenseg != 7'b011_1111) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end
  # 100ns;
  bcd = 4'b0001;
  # 100ns;
  if (sevenseg != 7'b000_0110) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end
  # 100ns;
  bcd = 4'b0010;
  # 100ns;
  if (sevenseg != 7'b101_1011) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end
  # 100ns;
  bcd = 4'b0011;
  # 100ns;
  if (sevenseg != 7'b100_1111) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end
  # 100ns;
  bcd = 4'b0100;
  # 100ns;
  if (sevenseg != 7'b110_0110) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end
  # 100ns;
  bcd = 4'b0101;
  # 100ns;
  if (sevenseg != 7'b110_1101) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end
  # 100ns;
  bcd = 4'b0110;
  # 100ns;
  if (sevenseg != 7'b111_1101) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end
  # 100ns;
  bcd = 4'b0111;
  # 100ns;
  if (sevenseg != 7'b000_0111) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end
  # 100ns;
  bcd = 4'b1000;
  # 100ns;
  if (sevenseg != 7'b111_1111) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end
  # 100ns;
  bcd = 4'b1001;
  # 100ns;
  if (sevenseg != 7'b110_1111) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end
  # 100ns;
  bcd = 4'b1111;
  # 100ns;
  if (sevenseg != 7'b000_0000) begin
    errors = errors + 1;
    $display ("Failure at input bcd=0b%b| sevenseg=0b%b",bcd,sevenseg);
  end

  if (errors==0) begin
    $display("\t :-) Test run PASSED :-) ");
  end else begin
    $display("\t :-( Test run FAILED with %d errors :-(",errors);
  end

  $display("########## End test! ############");
end

endmodule
