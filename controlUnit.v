module controlUnit(
	// input control signals
	input clk, reset, load_input,
	// feedback from data path
	input [4:0] counter, count_to,
	// output control signals
	output reg internal_reset, mux_sel, load_output, counter_enb, done);
	
	
	reg[1:0] state;
	reg[1:0] nextState;
	
	
	// Initialize the code with state = 0
	initial begin
		state <= 0;
	end
	
	always @(posedge clk or negedge reset) begin
		
		if(~reset) begin									// Reset
			state <= 0;
		end
		
		else begin											// Clock edge
			state <= nextState;
		end
	end
		
	always @(*) begin
		mux_sel = 1; 										// default start value (0 and 1)
		internal_reset = 1;								// resets the counter AND (current and previous) registers
		load_output = 0;
		counter_enb = 0; 
		done = 0;
		
		
		case (state)
		
			// State 0: idle, only wait for (go) signal to load the input
			0: begin
				// if go is recieved, load the input register and go to state 1
				if (load_input) begin
					internal_reset = 0; 					// Reseet any previous values in the counter and regs before proceeding to next state.
					nextState = state + 1;
				end
				else 
					nextState = state;
			end
			
			// State 1: start counting and summing
			1: begin
				mux_sel = 1;								// choose starting values of the sequence (0, 1)
				internal_reset = 1;						// counter and regs un-reset
				counter_enb = 1;							// start counting
				nextState = state + 1;
			end
			
			// State 2: keep counting until the counter reaches its value
			2: begin
				mux_sel = 0;								// pass previous and current value of the sequence to the adder
				counter_enb = 1;
				if(counter == count_to) begin			// if countr arrive at its value, enable the load signal of output register
					load_output = 1;
					nextState = state + 1; 
				end
				else
					nextState = state;
			end
			
			// State 3: make (done) signal high, then sends the controller back to state 0.
			3: begin
				done = 1;				
				nextState = 0;
			end
		endcase

	end

endmodule
