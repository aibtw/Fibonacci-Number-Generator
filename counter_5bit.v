module counter_5bit(clk, reset, count_en, count);
	
	input clk, reset, count_en;
	output reg [4:0] count;
	
	always @(posedge clk or negedge reset) begin
		if(~reset)
			count <= 0;
		else
			if(count_en)
				count <= count + 1'b1;
	end
endmodule
