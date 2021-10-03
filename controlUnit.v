module controlUnit(
	// input control signals
	input clk, reset, go,
	// feedback from data path
	input [4:0] counter, count_to,
	// output control signals
	output reg counter_reset, mux_sel, inout_enb, enb, done);
	
	reg[1:0] state;
	reg[1:0] nextState;
	
	// Initialize the code with state = 0
	initial begin
		state <= 0;
	end
	
	always @(posedge clk or negedge reset) begin
		// Reset
		if(~reset) begin
			nextState <= 0;
			mux_sel <= 1;
			inout_enb <= 0;
			counter_reset <= 0;
			done <= 0;
			enb <= 0;
		end
		
		// Clock edge
		else begin
			state <= nextState;
		end
		
		
		case (state)
			// State 0: idle
			0: begin
				mux_sel <= 1;
				inout_enb <= 0;
				counter_reset <= 0;
				done <= 0;
				enb <= 0;

				// if go is recieved go to state 1
				if (go) begin 
					nextState <= state + 1;
				end
				else
					nextState <= state;
			end
			
			// State 1: start counting
			1: begin
				mux_sel <= 1;
				inout_enb <= 1;
				counter_reset <= 1;
				enb <= 1;
				// output_en <= 0;
				nextState <= state + 1;
			end
			
			// State 2: keep counting until the counter reaches its value
			2: begin
				mux_sel <= 0;
				inout_enb <= 0;
				if(counter == count_to) begin
					nextState <= state + 1;
					inout_enb <= 1; 
				end
				else
					nextState <= state;
			end
			
			// State 3: make (done) signal high, then sends the controller back to state 0.
			3: begin
				done <= 1;
				counter_reset <= 0;
				inout_enb <= 0;
				// output_en <= 1;
				nextState <= 0;
			end
		endcase

	end
			
endmodule
