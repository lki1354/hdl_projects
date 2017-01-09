// ----------------------------
// Aufgabe 2 – Zähler
// Module	count_003
// Erstellen Sie ein SystemVerilog Module "count_1596" das folgende Funktion implementiert (7 Punkte):
//  - 10 Bit Binärzähler mit einstellbarer Zählrichtung, parallel load und enable.
//  - Es gibt ein active low reset signal.
//  - Die Clock besitzt eine Frequenz von 5 MHz.
// Author	kil
// Version	v0, 12.12.2016
// ----------------------------

/*----------------------------
Eingänge:
- rst_n (active low reset).
- eine Clock --> bitte sprechenden Namen verwenden (aktive Flanke: posedge).
- data_in: (Daten für parallel load, gleiche Bitbreite wie der Zähler).
- load
- updn (Zählrichtung, siehe unten).
- en: Enable für den Zähler.
- Ausgang: cnt (Zählerstand).
Funktionalität:
- Parallel load: Wenn "load==1" --> cnt = data_in.
- Zählrichtung: Wenn "updn==0" --> aufwärts, sonst abwärts.
- Enable: Wenn "en==1" --> Zähler zählt, sonst Zähler steht.
----------------------------*/

module count_003 #(parameter TOP_BIT=9)(
  input logic rst_n,
  input logic clk,
  input logic [TOP_BIT:0] data_in,
  input logic load,
  input logic updn,
  input logic en,

  output logic [TOP_BIT:0] cnt,
  output logic co
);
//parameter TOP_BIT = 10;

always_ff @ (posedge clk or rst_n) begin
  if (rst_n == 1'b0) begin
    cnt <= '0;
  end
  else if (load == 1'b1) begin
      cnt <= data_in;
  end
  else if (en == 1'b1) begin
    if(updn == 1'b0) begin
      cnt <= cnt + 1'b1;
    end else  begin
      cnt <= cnt - 1'b1;
    end
  end
  if (cnt == '1) begin
    co <= 1'b1;
  end else begin
    co <= 1'b0;
  end
end


endmodule // count_003
