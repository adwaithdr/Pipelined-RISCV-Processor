module controlunit(opcode,funct3,funct7,
                   regwrite,resultsrc,
						 memwrite,branch,
						 alucontrol,alusrc,immsrc);
						 
	input logic [6:0]opcode;
	input logic [2:0]funct3;
	input logic [6:0]funct7;
	output logic branch;
	output logic regwrite,memwrite,alusrc;
	output logic [2:0]alucontrol;
    output logic [1:0]immsrc,resultsrc;
	 logic [1:0]aluop;
     main_decoder md(.opcode(opcode),.resultsrc(resultsrc),.immsrc(immsrc),
             .memwrite(memwrite),
				 .regwrite(regwrite),.alusrc(alusrc),.aluop(aluop),
				 .branch(branch)); 
				 
	  alu_decoder ad(.funct3(funct3),.funct7(funct7),
                 .op5(opcode[5]),.aluop(aluop),
					  .alucontrol(alucontrol));
					  
	endmodule
				 	
                    