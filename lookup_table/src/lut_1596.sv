// ----------------------------
// Aufgabe 1 – Kombinatorische Logik
// Module	lut_1596
// Implementieren Sie die folgende Wahrheitstabelle in System Verilog
// Author	kil
// Version	v0, 11.12.2016
// ----------------------------

/*----------------------------
Wahrheitstabelle:
x[3]	x[2]	x[1]	x[0]	y
0 0	0	0	0
0	0	0	1	0
0	0	1	0	0
0	0	1	1	0
0	1	0	0	1_
0	1	0	1	0
0	1	1	0	0
0	1	1	1	0
1	0	0	0	1_
1	0	0	1	0
1	0	1	0	1_
1	0	1	1	0
1	1	0	0	0
1	1	0	1	0
1	1	1	0	0
1	1	1	1	0
----------------------------*/

module lut_1596 (
  input logic [3:0] x,
  output logic y
);

  always_comb begin
    case (x)
      4'b0100:  y=1'b1;
      4'b1000:  y=1'b1;
      4'b1010:  y=1'b1;
      default:  y=1'b0;
    endcase
  end


endmodule // lut_1596
