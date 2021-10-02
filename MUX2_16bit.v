module MUX2_16bit(in0, in1, sel, out);
	
	input sel;
	input [15:0] int0, in1;
	output reg [15:0] out;
	
	always @(*) begin
		if (sel == 1'b0)
			out = in0;
		else
			out = in1;
	end

endmodule
