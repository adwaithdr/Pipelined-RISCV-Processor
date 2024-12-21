module decode_cycle(clk,rst,instrd,pcd,pcplus4d,
                  regwriteE,regwriteW,reslw,resultsrcE,
						memwriteE,branchE,jumpE,alucontrolE,
						alusrcE,rd1E,rd2E,pce,rdE,immextE,
						pcplus4e,rs1E,rs2E,rdw);
						
	input logic [31:0]instrd,pcplus4d; 
	input logic [31:0]pcd;
	input logic rst,clk;
	input logic regwriteW;
	input logic [4:0]rdw;
	output logic [4:0]rdE,rs1E,rs2E;
	input logic [31:0]reslw;
	output logic regwriteE,branchE,jumpE;
	output logic [1:0]resultsrcE;
	output logic memwriteE,alusrcE;
	output logic [2:0]alucontrolE;
	output logic [31:0] rd1E,rd2E;
	output logic [31:0] immextE;
	output logic [31:0] pce,pcplus4e;
	
	logic regwrite_r,branch_r;
	logic memwrite_r,alusrc_r;            // declaring all the registers
	logic [2:0]alucontrol_r;
	logic [31:0]rd1_r,rd2_r;
	logic [31:0]immext_r,pcplus4_r,pcd_r;
	logic [4:0]rd_r,rs1_r,rs2_r;
	logic [1:0]resultsrc_r;
	
	logic regwrite_D,branch_D;
	logic [1:0]resultsrc_D;
	logic memwrite_D,alusrc_D;           // declaring all the output signals of control unit
    logic [1:0]immsrc_D;   
    logic [31:0]rd1_d,rd2_d;    
    logic [31:0]immext_D;                                                      	
	logic [2:0]alucontrol_D;
	logic we3;
	controlunit cu(.opcode(instrd[6:0]),.funct3(instrd[14:12]),.funct7(instrd[31:25]),
                   .regwrite(regwrite_D),.resultsrc(resultsrc_D),
						 .memwrite(memwrite_D),.branch(branch_D),
						 .alucontrol(alucontrol_D),.alusrc(alusrc_D),.immsrc(immsrc_D));
						 
	 register_file rf(.A1(instrd[19:15]),.A2(instrd[24:20]),.rst(rst),
	                  .A3(rdw),.WD3(reslw),.clk(clk),.WE3(regwriteW),
							.RD1(rd1_d),.RD2(rd2_d));
	
	sign_extend se(.Instrd(instrd[31:0]),.Immsrc(immsrc_D),.Immextd(immext_D));
	
	always_ff@(posedge clk)begin
	     if (rst==1'b1) begin
		     regwrite_r<=regwrite_D;
			  resultsrc_r<=resultsrc_D;
			  memwrite_r<=memwrite_D;
			  branch_r<=branch_D;
			  alucontrol_r<=alucontrol_D;
			  alusrc_r<=alusrc_D;
			  rd1_r<=rd1_d;
			  rd2_r<=rd2_d;
			  rs1_r<=instrd[19:15];
			  rs2_r<=instrd[24:20];
			  immext_r<=immext_D;
			  pcplus4_r<=pcplus4d;
			  rd_r<=instrd[11:7];
			  pcd_r<=pcd;
			 end
			else   begin
		     regwrite_r<=0;
			  resultsrc_r<=0;
			  memwrite_r<=0;
			  branch_r<=0;
			  alucontrol_r<=0;
			  alusrc_r<=0;
			  rd1_r<=0;
			  rd2_r<=0;
			  rs1_r<=0;
			  rs2_r<=0;
			  immext_r<=0;
			  pcplus4_r<=0;
			  rd_r<=0;
			  pcd_r<=0;
			 end
	end
	always_comb  begin
	
	  regwriteE = regwrite_r;
	  resultsrcE = resultsrc_r;
	  memwriteE = memwrite_r;
	  branchE = branch_r;
	  alucontrolE = alucontrol_r;
	  alusrcE = alusrc_r;
	  rd1E = rd1_r;
	  rd2E = rd2_r;
	  rs1E = rs1_r;
	  rs2E = rs2_r;
	  rdE = rd_r;
	  immextE = immext_r;
	  pcplus4e = pcplus4_r;
	  pce = pcd_r;
	 end
endmodule
			   