/*!
 *  \file clock_sm.sv
 *  \brief a state machine for a clock
 *  \author Lukas Kiechle
 *  \date 2016-12-16 create date
 *  $Revision: 0.9$
*/


module clock_sm (
	input logic clk,
	input logic rst_n,
	input logic key_short,
	input logic key_long,
	output logic	HHMM_view,
	output logic	MMSS_view,
	output logic	S_H1,
	output logic	S_H2,
	output logic 	S_M1,
	output logic 	S_M2,
	output logic	S_S1,
	output logic	S_S2,
	output logic[2:0] state
);

// internal state and next state
enum logic [2:0] {CLOCK_IDLE,CLOCK_SECOND,SET_H1,SET_H2,SET_M1,SET_M2,SET_S1,SET_S2} state_in,state_next;

always_ff @ (negedge rst_n or posedge clk) begin
	if (!rst_n) begin
		state_in <= CLOCK_IDLE;
		//state_next <= CLOCK_IDLE;
	end
	else begin
		state_in <= state_next;
	end
end

always_comb begin
	case (state_in)
		CLOCK_IDLE : begin
			HHMM_view = 1'b1;
		  MMSS_view = 1'b0;
			S_H1 = 1'b0;
			S_H2 = 1'b0;
			S_M1 = 1'b0;
			S_M2 = 1'b0;
			S_S1 = 1'b0;
			S_S2 = 1'b0;
			if ( key_short ) begin
				state_next = CLOCK_SECOND;
			end
			else if( key_long )begin
				state_next = SET_H1;
			end else begin
				state_next = state_in;
			end
		end
		CLOCK_SECOND : begin
			HHMM_view = 1'b0;
			MMSS_view = 1'b1;
			S_H1 = 1'b0;
			S_H2 = 1'b0;
			S_M1 = 1'b0;
			S_M2 = 1'b0;
			S_S1 = 1'b0;
			S_S2 = 1'b0;
			if ( key_short ) begin
				state_next = CLOCK_IDLE;
			end else begin
				state_next = state_in;
			end
		end
		SET_H1 : begin
			HHMM_view = 1'b0;
			MMSS_view = 1'b0;
			S_H1 = 1'b1;
			S_H2 = 1'b0;
			S_M1 = 1'b0;
			S_M2 = 1'b0;
			S_S1 = 1'b0;
			S_S2 = 1'b0;
			if(key_short )begin
				state_next = SET_H2;	// explicit cast
			end else begin
				state_next = state_in;
			end
		end
		SET_H2 : begin
			HHMM_view = 1'b0;
			MMSS_view = 1'b0;
			S_H1 = 1'b0;
			S_H2 = 1'b1;
			S_M1 = 1'b0;
			S_M2 = 1'b0;
			S_S1 = 1'b0;
			S_S2 = 1'b0;
			if(key_short )begin
				state_next = SET_M1;	// explicit cast
			end else begin
				state_next = state_in;
			end
		end
		SET_M1 : begin
			HHMM_view = 1'b0;
			MMSS_view = 1'b0;
			S_H1 = 1'b0;
			S_H2 = 1'b0;
			S_M1 = 1'b1;
			S_M2 = 1'b0;
			S_S1 = 1'b0;
			S_S2 = 1'b0;
			if(key_short )begin
				state_next = SET_M2;	// explicit cast
			end else begin
				state_next = state_in;
			end
		end
		SET_M2 : begin
			HHMM_view = 1'b0;
			MMSS_view = 1'b0;
			S_H1 = 1'b0;
			S_H2 = 1'b0;
			S_M1 = 1'b0;
			S_M2 = 1'b1;
			S_S1 = 1'b0;
			S_S2 = 1'b0;
			if(key_short )begin
				state_next = SET_S1;	// explicit cast
			end else begin
				state_next = state_in;
			end
		end
		SET_S1 : begin
			HHMM_view = 1'b0;
			MMSS_view = 1'b0;
			S_H1 = 1'b0;
			S_H2 = 1'b0;
			S_M1 = 1'b0;
			S_M2 = 1'b0;
			S_S1 = 1'b1;
			S_S2 = 1'b0;
			if(key_short )begin
				state_next = SET_S2;	// explicit cast
			end else begin
				state_next = state_in;
			end
		end
		SET_S2 : begin
			HHMM_view = 1'b0;
			MMSS_view = 1'b0;
			S_H1 = 1'b0;
			S_H2 = 1'b0;
			S_M1 = 1'b0;
			S_M2 = 1'b0;
			S_S1 = 1'b0;
			S_S2 = 1'b1;
			if(key_short )begin
				state_next = CLOCK_IDLE;
			end else begin
				state_next = state_in;
			end
		end
	endcase
end

// connect internal state to an output for debugging
assign state = state_in;

endmodule
