module register_16bit(clk, reset, d, q);

	input clk, reset;
	input  [15:0] d;
	output reg [15:0] q;

	always @(posedge clk) begin
		q <= d;
	end
	
	always @(negedge reset) begin
		q <= 0;
	end

endmodule
