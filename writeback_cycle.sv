module writeback_cycle(clk,rst,aluresultW,
                        readdataW,pcplus4w,
								resultsrcW,resultW);
								
	input logic clk,rst;

	input logic [31:0] aluresultW,readdataW,pcplus4w;
	input logic [1:0] resultsrcW;
	 output logic [31:0] resultW;

	mux3_1 m31(.i0(aluresultW),.i1(readdataW),.i2(pcplus4w),
	           .s(resultsrcW),.o(resultW));
	
	endmodule
	