module dataPath(
	input clk, reset, first_time, enb, count_enb,
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
	
	localparam [15:0] mux0_in1=1;  
	localparam [15:0] mux1_in1=0;
	
	assign nth_fib = current_val;
	
	register_16bit input_reg(clk, reset, enb, numberIn, count_to);
	
	counter_5bit counter(clk, reset, count_enb, count);
	
	register_16bit current_reg(clk, reset, count_enb, mux0_out, current_val);  
	register_16bit prev_reg(clk, reset, count_enb, mux1_out, prev_val);

	MUX2_16bit mux0(sum, mux0_in1, first_time, mux0_out); 
	MUX2_16bit mux1(current_val, mux1_in1, first_time, mux1_out);
	
	adder_16bit adder(current_val, prev_val, sum);

	

endmodule
