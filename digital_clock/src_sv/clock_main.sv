/*!
 *  \file clock_main.sv
 *  \brief integrate all submodules and connect it together to build a clock
 *  \author Lukas Kiechle
 *  \date 2016-12-16 create date
 *  $Revision: 0.9$
*/


module clock_main(
  // ---- connections to FPGA pins
  input  logic             rst_n,
  input  logic             clk50m,
  input  logic             button_sm,
  input  logic             button_count,
  input  logic             button_sec_enable,

  output logic [2:0] state,

  output logic    [6:0]    seg3,
  output logic    [6:0]    seg2,
  output logic    [6:0]    seg1,
  output logic    [6:0]    seg0
);
  // ---- wiring internal between modules ----
  logic           enable_mux = 1'b1;
  logic           clk_1sec;
  logic			    	pulse_1sec;
  logic           short_press;
  logic           long_press;
  logic           key_count_up;
  logic           view_hours;
  logic           view_seconds;
  logic   [3:0]   bcd_H1;
  logic   [3:0]   bcd_H2;
  logic   [3:0]   bcd_M1;
  logic   [3:0]   bcd_M2;
  logic   [3:0]   bcd_S1;
  logic   [3:0]   bcd_S2;

  logic   [3:0]   bcd3;
  logic   [3:0]   bcd2;
  logic   [3:0]   bcd1;
  logic   [3:0]   bcd0;

  logic      update_H1;
  logic      update_H2;
  logic      update_M1;
  logic      update_M2;
  logic      update_S1;
  logic      update_S2;
  logic [3:0]load;

  // ---- start to use submodules and do wiring ----

    // create a one second clock
//calculate devider : count = time {new clock pulse [s]]} * frequenzy {input clock [Hz]}
  clock_divider #(.count_start(25000000) ) gen_sec_clock(
    .clk (clk50m),
    .rst_n  (rst_n),
    .enable (button_sec_enable),
    .clk_out (clk_1sec)
  );

  clock_sm state_machine(
    .clk (clk50m),
    .rst_n  (rst_n),
    .key_short (short_press),
    .key_long (long_press),
    .HHMM_view (view_hours),
    .MMSS_view (view_seconds),
    .S_H1 (update_H1),
    .S_H2 (update_H2),
    .S_M1 (update_M1),
    .S_M2 (update_M2),
    .S_S1 (update_S1),
    .S_S2 (update_S2),
    .state  (state)
  );

  // debounc and dicide between long and short press of button
  key_long_short        key_sm(
      .rst_n          (rst_n),
      .clk         (clk50m),
      .button             (button_sm),
      .key_press_short       (short_press),
      .key_press_long    (long_press)
  );

  // button debouncer for configure clock manually
  debounce key_count (
    .rst_n(rst_n),
  	.clk(clk50m),
  	.button(button_count),
  	.valid_ff(),
  	.valid_pulse(key_count_up)
  );

  // create a pulse for one working clock periode from the 1 second clock
	pulse_generator pulse_g(
	    .rst_n          (rst_n),
      .clk         (clk50m),
      .input_signal      (clk_1sec),
		  .pulse (pulse_1sec)
	 );

  // 6digit bcd counter for flock values hour:minute:second
  bcd_6digit      u1_bcd_6digit(
    .rst_n            (rst_n),
    .clk              (clk50m),
    .cnt_en           (pulse_1sec),
    .update_H1        (update_H1),
    .update_H2        (update_H2),
    .update_M1        (update_M1),
    .update_M2        (update_M2),
    .update_S1        (update_S1),
    .update_S2        (update_S2),
    .update_count     (key_count_up),
    .bcd_H1           (bcd_H1),
    .bcd_H2           (bcd_H2),
    .bcd_M1           (bcd_M1),
    .bcd_M2           (bcd_M2),
    .bcd_S1           (bcd_S1),
    .bcd_S2           (bcd_S2)
  );

  // mux for the right view on the 7 segment display
  mux_clock mux_seg(
    .hour_miniute (view_hours),		// Pulse
  	.second  (view_seconds),		// Pulse
    .update_H1(update_H1),
    .update_H2(update_H2),
    .update_M1(update_M1),
    .update_M2(update_M2),
    .update_S1(update_S1),
    .update_S2(update_S2),
    .blink (clk_1sec),		// Pulse
  	.bcd_H1 (bcd_H1),		// One BCD digit
  	.bcd_H2 (bcd_H2),		// One BCD digit
  	.bcd_M1 (bcd_M1),		// One BCD digit
  	.bcd_M2 (bcd_M2),		// One BCD digit
  	.bcd_S1 (bcd_S1),		// One BCD digit
  	.bcd_S2 (bcd_S2),		// One BCD digit

  	.bcd0 (bcd0),		// One BCD digit
  	.bcd1 (bcd1),		// One BCD digit
  	.bcd2 (bcd2),		// One BCD digit
  	.bcd3 (bcd3)	// One BCD digit
  );

    // 4 x seven segment decoder
    sevenseg_decoder u0_sevenseg_decoder(
        .bcd            (bcd0),
        .sevenseg       (), // unconnected
        .sevenseg_n     (seg0)
    );

    sevenseg_decoder u1_sevenseg_decoder(
        .bcd            (bcd1),
        .sevenseg       (), // unconnected
        .sevenseg_n     (seg1)
    );

    sevenseg_decoder u2_sevenseg_decoder(
        .bcd            (bcd2),
        .sevenseg       (), // unconnected
        .sevenseg_n     (seg2)
    );

    sevenseg_decoder u3_sevenseg_decoder(
        .bcd            (bcd3),
        .sevenseg       (), // unconnected
        .sevenseg_n     (seg3)
    );


endmodule
