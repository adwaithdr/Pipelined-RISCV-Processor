module fetch_cycle(clk,rst,pctare,pcsrc,instrd,pcd,pcplus4D);
     input logic clk,rst;
	  input logic [31:0]pctare;
	  input logic pcsrc;
	  output logic [31:0]pcd,pcplus4D;
	  output logic [31:0]instrd;
	  logic [31:0]pcf,pcfplus;
	  logic [31:0]pcplus4f;
	  logic [31:0]instrf;
	  
	  //Decalaring registers
	  logic [31:0]pcd_reg,pcplus4D_reg;
      logic [31:0]instrd_reg;
	  
	  pc_mux pm(.i1(pctare),
	         .i0(pcplus4f),
				.s0(pcsrc),
				.o(pcfplus));
				
	  adder adpc(.a(pcf),
	             .b(32'h0000004),
					 .s(pcplus4f));
					 
     pc_counter pc(.clk(clk),
	                .rst(rst),
						 .pc(pcf),
						 .pc_next(pcfplus));
						 
	 Instruction_memory im(.rst(rst),
	                    .A(pcf),
							  .RD(instrf));
	always_ff@(posedge clk) begin
	   if (rst==1'b1) begin
	    instrd_reg<=instrf;
		 pcd_reg<=pcf;
		 pcplus4D_reg<=pcplus4f;
	end
	  else begin
	     instrd_reg<=32'h00000000;
		 pcd_reg<=32'h00000000;
		 pcplus4D_reg<=32'h00000000;
		 end
	end
	 always_comb begin
	   if (rst==1'b1) begin
		    pcd=pcd_reg;
			 pcplus4D=pcplus4D_reg;
			 instrd=instrd_reg;
			 end
		  else  begin
		 instrd =32'h00000000;
		 pcd =32'h00000000;
		 pcplus4D =32'h00000000;
		 end
		end
endmodule
