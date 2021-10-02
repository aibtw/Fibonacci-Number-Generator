module counter_5bit(clk, reset, count_en, count);
	
	input clk, reset, count_en;
	output reg [4:0] count;
	assign wire c = count;
	
	always @(posedge clk) begin
		if(count_en)
			count <= c + 1;
	end
	
	always @(negedge reset) begin
		count <= 0;
	end

endmodule
