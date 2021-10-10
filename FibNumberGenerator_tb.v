`timescale 1ns / 1ps
module FibNumberGenerator_tb();
	// inputs
	reg clk;
	reg go;
	reg [4:0] numberIn;
	reg reset;
	// outputs                                               
	wire done;
	wire [15:0] numberOut;

	// instantiation                    
	FibNumberGenerator i1 (
		.clk(clk),
		.done(done),
		.go(go),
		.numberIn(numberIn),
		.numberOut(numberOut),
		.reset(reset)
	);
	
	// clk
	always #5 clk = ~clk;
	
	
	initial begin
		// Initialize Inputs
		clk = 0;
		go = 0;
		numberIn = 0;
		
		// reset is active low. when reset is 0 the system will reset. when reset is 1 the system is not resetting.
		reset = 0;
		#5
		reset = 1;
		// delete this, do it like 1 then 0 then 1 
	
		
		// First input: 6. Expected result is 8.
		#15
		go = 1;
		numberIn = 6;		
		#10
		go = 0;
		numberIn = 0;
		#80
		

		// second input: 10, but reset before the result is out. Expected result: 0 because of reset.
		go = 1;
		numberIn = 10;
		#10
		go = 0;
		numberIn = 0;
		#20
		reset = 0;
		#10
		reset = 1;
		
		
		// Third input: 10. Expected result: 55.
		#30
		go = 1;
		numberIn = 10;
		#10
		go = 0;
		numberIn = 0;
		
		// Fourth input: 24. Expected result: 46368
		#140
		go = 1;
		numberIn = 24;
		#10
		go = 0;
		numberIn = 0;
		#275;
		$finish;

	end

	
endmodule
