module dataPath(
	input clk, usr_reset, cu_reset, first_time, load_input, load_output, counter_enb,
	input [4:0] numberIn,
	output [4:0] count_to,
	output [4:0] count,
	output [15:0] nth_fib 
	);
	
	wire [15:0] sum;	
	wire [15:0] mux0_out;
	wire [15:0] mux1_out;
	wire [15:0] current_val;
	wire [15:0] prev_val;
	
	// First time inputs for the multiplexers (first two numbers in Fib Series are 0, 1)
	localparam [15:0] mux0_in1=1;
	localparam [15:0] mux1_in1=0;
	
	// Input and output registers
	register_5bit input_reg(clk, usr_reset, load_input, numberIn, count_to);
	register_16bit output_reg(clk, usr_reset, load_output, current_val, nth_fib);

	// Counter
	counter_5bit counter(clk, usr_reset&cu_reset, counter_enb, count);
	
	// Current and previous value registers
	register_16bit current_reg(clk, usr_reset&cu_reset, 1'b1, mux0_out, current_val);  
	register_16bit prev_reg(clk, usr_reset&cu_reset, 1'b1, mux1_out, prev_val);
	
	// Multiplexers
	MUX2_16bit mux0(sum, mux0_in1, first_time, mux0_out); 
	MUX2_16bit mux1(current_val, mux1_in1, first_time, mux1_out);
	
	// Sum = current value + previous value.
	adder_16bit adder(current_val, prev_val, sum);

endmodule
