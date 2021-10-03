module FibNumberGenerator(
	input clk, reset, start, 
	input [15:0] numberIn,
	output done,
	output [15:0] numberOut
	);

	wire [15:0] count;
	wire [4:0] count_to;
	wire mux_sel, en, count_en, cu_reset;
	
	dataPath dp(clk, reset, cu_reset, mux_sel, en, count_en, numberIn, count_to, count, numberOut);
	
	controlUnit cu(clk, reset, start, count, count_to, cu_reset, mux_sel, en, count_en, done);
endmodule
