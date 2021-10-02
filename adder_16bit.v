module adder_16bit(x, y, res);
	
	input   [15:0] x, y;
	output  [15:0] res;
	
	assign res = x+y;

endmodule
