module hazard_unit(rst,rs1E,rs2E,forwardAE,forwardBE,
                    rdM,rdW,regwriteM,regwriteW);
						  
				input rst, regwriteM, regwriteW;
    input [4:0] rdM,rdW,rs1E,rs2E;
    output [1:0] forwardAE, forwardBE;
    
    assign forwardAE = (rst == 1'b0) ? 2'b00 : 
                       ((regwriteM == 1'b1) & (rdM != 5'h00) & (rdM == rs1E)) ? 2'b10 :
                       ((regwriteW == 1'b1) & (rdW != 5'h00) & (rdW == rs1E)) ? 2'b01 : 2'b00;
                       
    assign forwardBE = (rst == 1'b0) ? 2'b00 : 
                       ((regwriteM == 1'b1) & (rdM != 5'h00) & (rdM == rs2E)) ? 2'b10 :
                       ((regwriteW == 1'b1) & (rdW != 5'h00) & (rdW == rs2E)) ? 2'b01 : 2'b00;

endmodule