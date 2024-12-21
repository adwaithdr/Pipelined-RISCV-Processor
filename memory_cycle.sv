module memory_cycle(clk,rst,regwriteM,memwriteM,resultsrcM,
                     aluresultM,writedataM,rdM,pcplus4m,
							regwriteW,resultsrcW,aluresultW,
							readdataW,rdW,pcplus4w);
	input clk,rst;
	input logic regwriteM,memwriteM;
	input logic [1:0] resultsrcM;
	input logic [31:0] aluresultM,writedataM,pcplus4m;
	input logic [4:0] rdM;
	
	output logic regwriteW;
	output logic [1:0] resultsrcW;
	output logic [31:0] aluresultW,readdataW,pcplus4w;
	output logic [4:0] rdW;
	
	logic [31:0] readdataM;
   logic regwrite_r;
	logic [1:0] resultsrc_r;
   logic [31:0] aluresult_r,readdata_r,pcplus4_r;
	 logic [4:0] rdW_r;
	 data_memory dm(.clk(clk),.rst(rst),.A(aluresultM),.WD(writedataM),.WE(memwriteM),
	                  .RD(readdataM));
	 always_ff @(posedge clk) begin
	   if (rst == 1'b1) begin
	    regwrite_r <= regwriteM;
		 resultsrc_r <= resultsrcM;
		 aluresult_r <= aluresultM;
		 readdata_r <= readdataM;
		 rdW_r <= rdM;
		 pcplus4_r <= pcplus4m;
		 end
		 
		else begin
		 regwrite_r <= 0;
		 resultsrc_r <= 0;
		 aluresult_r <= 0;
		 readdata_r <= 0;
		 rdW_r <= 0;
		 pcplus4_r <= 0;
		   end
	end
	   always_comb begin
		  regwriteW = regwrite_r;
		  resultsrcW = resultsrc_r;
		  aluresultW = aluresult_r;
		  readdataW = readdata_r;
		  rdW =  rdW_r;
		  pcplus4w = pcplus4_r;
		 end
endmodule
		 
	 