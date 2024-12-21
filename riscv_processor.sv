module riscv_processor(clk,rst);

    input logic clk,rst;
	 logic [31:0]pctare;
	  logic pcsrc;
	   logic [31:0]pcd,pcplus4D;
	  logic [31:0]pcf,pcfplus;
	  logic [31:0]pcplus4f;
	  logic [31:0]instrf;
     logic [31:0]instrd,pcplus4d; 
    logic [4:0]rdw,rs1E,rs2E;
    logic [4:0]rdE,rdM;
    logic [31:0]reslw;
    logic regwriteE,branchE,jumpE;
     logic [1:0]resultsrcE;
    logic memwriteE,alusrcE;
	 logic [2:0]alucontrolE;
    logic [31:0] rd1E,rd2E;
    logic [31:0] immextE;
    logic [31:0] pce,pcplus4e;
 logic regwriteM,memwriteM,zeroE;
 logic [1:0]resultsrcM;
 logic [31:0]aluresultM,writedataM,pcplus4M;
 logic [31:0]pctargete;
 logic regwriteW;
  logic pcsrce;
   logic [1:0] resultsrcW,forwardAE,forwardBE;
   logic [31:0] aluresultW,readdataW,pcplus4w,resultW;


		
   fetch_cycle fc (.clk(clk),.rst(rst),.pctare(pctargete),
	             .pcsrc(pcsrce),.instrd(instrd),.pcd(pcd),.pcplus4D(pcplus4D));
	
	decode_cycle dc (.clk(clk),.rst(rst),.instrd(instrd),.pcd(pcd),.pcplus4d(pcplus4D),
                  .regwriteE(regwriteE),.regwriteW(regwriteW),.reslw(resultW),.resultsrcE(resultsrcE),
						.memwriteE(memwriteE),.branchE(branchE),.jumpE(jumpE),
						.alucontrolE(alucontrolE),
						.alusrcE(alusrcE),.rd1E(rd1E),.rd2E(rd2E),.pce(pce),.rdE(rdE),.immextE(immextE),
						.pcplus4e(pcplus4e),.rs1E(rs1E),.rs2E(rs2E),.rdw(rdw));
						
  execute_cycle ec(.clk(clk),.rst(rst),.regwriteE(regwriteE),.resultsrcE(resultsrcE),.memwriteE(memwriteE),.jumpE(jumpE),
                          .branchE(branchE),.alucontrolE(alucontrolE),.alusrcE(alusrcE),
								  .rd1E(rd1E),.rd2E(rd2E),.pce(pce),.rdE(rdE),.immextE(immextE),.pcplus4e(pcplus4e),
								  .pctargete(pctargete),.regwriteM(regwriteM),.resultsrcM(resultsrcM),
								  .memwriteM(memwriteM),.aluresultM(aluresultM),.writedataM(writedataM),.pcplus4M(pcplus4M),
								  .rdM(rdM),.zeroE(zeroE),.pcsrce(pcsrce),
								  .resultW(resultW),.forwardAE(forwardAE),
								  .forwardBE(forwardBE));
								  
	
	memory_cycle mc (.clk(clk),.rst(clk),.regwriteM(regwriteM),.memwriteM(memwriteM),.resultsrcM(resultsrcM),
                     .aluresultM(aluresultM),.writedataM(writedataM),.rdM(rdM),.pcplus4m(pcplus4M),
							.regwriteW(regwriteW),.resultsrcW(resultsrcW),.aluresultW(aluresultW),
							.readdataW(readdataW),.rdW(rdw),.pcplus4w(pcplus4w));
							
	writeback_cycle wc (.clk(clk),.rst(rst),.aluresultW(aluresultW),
                        .readdataW(readdataW),.pcplus4w(pcplus4w),
								.resultsrcW(resultsrcW),.resultW(resultW));
							
	hazard_unit hu(.rst(rst),.rs1E(rs1E),.rs2E(rs2E),
	            .forwardAE(forwardAE),.forwardBE(forwardBE),
                    .rdM(rdM),.rdW(rdw),.regwriteM(regwriteM),.regwriteW(regwriteW));
endmodule
module tb();

    reg clk=0, rst;
    
    always begin
        clk = ~clk;
        #50;
    end

    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;
        #1000;
        $finish;    
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

    riscv_processor dut (.clk(clk), .rst(rst));
endmodule