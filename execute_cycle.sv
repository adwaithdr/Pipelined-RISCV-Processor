module execute_cycle(clk,rst,regwriteE,resultsrcE,memwriteE,jumpE,
                          branchE,alucontrolE,alusrcE,
								  rd1E,rd2E,pce,rdE,immextE,pcplus4e,
								  pctargete,regwriteM,resultsrcM,
								  memwriteM,aluresultM,writedataM,pcplus4M,
								  rdM,zeroE,pcsrce,resultW,forwardAE,forwardBE);
  input logic clk,rst;							  
 input logic regwriteE,memwriteE,jumpE;
 input logic [1:0] resultsrcE,forwardAE,forwardBE;
 input logic branchE,alusrcE;
 input logic [2:0]alucontrolE;
 input logic [31:0] rd1E,rd2E;
 input logic [4:0] rdE;
 output logic [4:0] rdM;
 input logic [31:0] pce,immextE,pcplus4e,resultW;
 output logic regwriteM,memwriteM,zeroE;
 output logic [1:0]resultsrcM;
 output logic [31:0]aluresultM,writedataM,pcplus4M;
 output logic [31:0]pctargete;
 output logic pcsrce;
 
 logic regwrite_r,memwrite_r;
 logic [1:0] resultsrc_r;
 logic [4:0] rd_r;
 logic [31:0] pcplus4_r;
 logic [31:0] writedata_r;
 logic [31:0] aluresult_r;
 logic [31:0] result;
 logic[31:0] srcA,srcB,writedataE;
 
  mux3_1 mu(.i0(rd1E),.i1(resultW),.i2(aluresultM),.s(forwardAE),.o(srcA));
  
  mux3_1 mn(.i0(rd2E),.i1(resultW),.i2(aluresultM),.s(forwardBE),.o(writedataE));
 
  pc_mux #(32) pm (.i1(immextE),.i0(writedataE),.s0(alusrcE),.o(srcB));
  
  ALU a(.A(srcA),.B(srcB),.control(alucontrolE),.result(result),.zero(zeroE));
  
  adder ad(.a(pce),.b(immextE),.s(pctargete));
  
  assign pcsrce = (branchE & zeroE);
  always_ff @(posedge clk)begin
     if (rst == 1'b1) begin
	       regwrite_r<=regwriteE;
			 resultsrc_r<=resultsrcE;
			 memwrite_r<=memwriteE;
			 aluresult_r<=result;
			 writedata_r<=writedataE;
			 rd_r<=rdE;
			 pcplus4_r<=pcplus4e;	
			end
			
	  else  begin
	      regwrite_r<= 0;
			 resultsrc_r<= 0;
			 memwrite_r<= 0;
			 aluresult_r<= 0;
			 writedata_r<= 0;
			 rd_r<= 0;
			 pcplus4_r<= 0;
		end
   end
	always_comb begin
	   regwriteM = regwrite_r;
		resultsrcM = resultsrc_r;
	   memwriteM = memwrite_r;
		aluresultM = aluresult_r;
		writedataM = writedata_r;
		pcplus4M = pcplus4_r;
		rdM = rd_r;
	end
endmodule