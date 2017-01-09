/*-----------------------------------
Project:



-----------------------------------*/


// No need for library calls

module washing_machine (
	input logic		start,
	input logic		full,
	input logic		hot,
	input logic		clean,
	input logic 	rst_n,
	input logic 	clk,
	output logic	heater,
	output logic	valve,
	output logic	motor,
	output logic	pump,
	output logic 	door_lock //no , here
);

enum logic [2:0] {IDLE,H20,WARM,WASH,PUMP} state, state_new;

always_ff @ (negedge rst_n or posedge clk) begin
	if (!rst_n) begin
		state <= IDLE;
	end
	else begin
		state <= state_new;
	end
end 


always_comb begin
	case (state)
		IDLE : begin
			heater = 0;
			valve = 0;
			motor = 0;
			pump = 0;
			door_lock = 0;
			if (start) begin
				state_new = H20;
			end
			else begin
				state_new = state;
			end
		end
		H20 : begin
			heater = 0;
			valve = 1;
			motor = 0;
			pump = 0;
			door_lock = 1;
			if (full) begin
				state_new = WARM;
			end
			else begin
				state_new = state;
			end
		end
		WARM : begin
			heater = 1;
			valve = 0;
			motor = 0;
			pump = 0;
			door_lock = 1;
			if (hot) begin
				state_new = WASH;
			end
			else begin
				state_new = state;
			end
		end
		WASH : begin
			heater = 0;
			valve = 0;
			motor = 1;
			pump = 0;
			door_lock = 1;
			if (clean) begin
				state_new = PUMP;
			end
			else begin
				state_new = state;
			end
		end
		PUMP : begin
			heater = 0;
			valve = 0;
			motor = 0;
			pump = 1;
			door_lock = 1;
			if (full) begin
				state_new = IDLE;
			end
			else begin
				state_new = state;
			end
		end
	
	endcase
end

endmodule