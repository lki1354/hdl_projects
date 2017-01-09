// ----------------------------
// Aufgabe 3 – Finite State Machine
// Module	fsm_door_003
// Es ist eine Steuerung für ein Rolltor zu erstellen
// Author	kil
// Version	v0, 12.12.2016
// ----------------------------

/*----------------------------
Eingänge :
- Active low reset.
- Clock mit aktiver Flanke = posedge. Frequenz = 2 MHz.
- key_up --> Wenn dieser Taster == 1 wird, soll sich das Garagentor öffnen. Dies gilt für den geschlossenen Zustand und während des Schließens.
- key_down --> Wenn dieser Taster == 1 wird, soll sich das Garagentor schließen. Dies gilt für den offenen Zustand und während des Öffnens.
- sense_up --> Dieser Sensor zeigt an, dass das Rolltor seine obere Endposition erreicht hat --> Das Tor ist offen.
- sense_down --> Dieser Sensor zeigt an, dass das Rolltor seine untere Endposition erreicht hat --> Das Tor ist geschlossen.
Ausgänge (Einrichtungen die gesteuert werden müssen):
- ml = 1 --> Motor is aktiv, dreht links und das Tor schließt sich.
- mr = 1 --> Motor is aktiv, dreht rechts und das Tor öffnet sich.
- Werden ml und mr = 0 gesetzt, so steht der Motor und das Tor bewegt sich nicht.
- Werden ml und mr = 1 gesetzt, so wird der Motor zerstört.
- light_red = 1 --> Rote Ampel leuchtet. Dies soll während aller Torbewegungen und im geschlossenen Zustand erfolgen.
- light_green = 1 --> Grüne Ampel leuchtet. Dies soll nur bei offenen Tor erfolgen.
----------------------------*/

module fsm_door_003 (
  input logic rst_n,
  input logic clk,
  input logic key_up,
  input logic key_down,
  input logic sense_up,
  input logic sense_down,

  output logic ml,
  output logic mr,
  output logic light_red,
  output logic light_green,
  output logic [2:0] db_state

);
//parameter TOP_BIT = 10;
/*
logic ml_internal;
logic mr_internal;
*/
enum logic [2:0] {STOP,CLOSED,OPEN,DO_OPEN,DO_CLOSE} state, state_new = STOP, state_next = STOP;


always_ff @ (posedge clk or rst_n) begin : input_handl
  if (rst_n == 1'b0) begin
    state <= STOP;
  end
  else begin
      state <= state_new;
  end
end

always_comb begin : state_machine
  if (key_up==1'b1 && key_down==1'b1) begin //check if both keys are pressed
    state_new = STOP;
    state_next = STOP;
  end

  //start state machine
  case (state)
    STOP: begin
      ml = 1'b0;
      mr = 1'b0;
      light_green = 1'b0;
      if (state_next == STOP && key_up != key_down) begin // only for reset and both keys are pressed
        light_red <= 1'b1;
        if (sense_up==1'b1) begin
          state_next = OPEN;
        end else if (sense_down==1'b1) begin
          state_next = CLOSED;
        end else if (key_up==1'b1) begin
            state_next = DO_OPEN;
        end else if (key_down==1'b1) begin
            state_next = DO_CLOSE;
        end else begin
          state_next = STOP;
        end
      end
      state_new = state_next;
    end
    CLOSED: begin
      light_red = 1'b1;
      if (key_up) begin
        state_new = DO_OPEN;
      end
    end
    OPEN: begin
      light_red = 1'b0;
      light_green = 1'b1;
      if (key_down) begin
        state_new = DO_CLOSE;
        light_green = 1'b0;
      end
    end
    DO_OPEN: begin
      mr = 1'b1;
      light_red = 1'b1;
      if (sense_up == 1'b1) begin
        state_new = STOP;
        state_next = OPEN;
      end else if (key_down == 1'b1) begin
        state_new = STOP;
        state_next = DO_CLOSE;
      end
    end
    DO_CLOSE: begin
      ml = 1'b1;
      light_red = 1'b1;
      if (sense_down == 1'b1) begin
        state_new = STOP;
        state_next = CLOSED;
      end else if (key_up == 1'b1) begin
        state_new = STOP;
        state_next = DO_OPEN;
      end
    end
    default: ;
  endcase

end

assign db_state = state;


endmodule // fsm_door_003
