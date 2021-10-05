module FibNumberGenerator(
	input clk, reset, go, 
	input [4:0] numberIn,
	output done,
	output [15:0] numberOut
	);

	wire [15:0] counter;
	wire [4:0] count_to;
	wire mux_sel, counter_enb, count_en, cu_reset;
	
	dataPath dp(clk, reset, cu_reset, mux_sel, go, counter_enb, count_en, numberIn, count_to, counter, numberOut);
	
	controlUnit cu(clk, reset, go, counter, count_to, cu_reset, mux_sel, counter_enb, count_en, done);
endmodule
