module register_16bit(clk, reset, load, d, q);

	input clk, reset, load;
	input  [15:0] d;
	output reg [15:0] q;
	
	
	always @(posedge clk or negedge reset) begin
		if(~reset)
			q <= 0;
		else
			if(load)
				q <= d;
	end

endmodule
