module register_5bit(clk, reset, load, d, q);

	input clk, reset, load;
	input  [4:0] d;
	output reg [4:0] q;
	
	
	always @(posedge clk or negedge reset) begin
		if(~reset)
			q <= 0;
		else
			if(load)
				q <= d;
	end

endmodule
