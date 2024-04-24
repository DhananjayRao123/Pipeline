module forwarding_unit(rd_EX_MEM, rd_MEM_WB, rs_ID_EX, rt_ID_EX, RegWrite_EX_MEM, RegWrite_MEM_WB, ALU_SrcA_fwd, ALU_SrcB_fwd);
    input [4:0] rd_EX_MEM, rd_MEM_WB, rs_ID_EX, rt_ID_EX;
    input RegWrite_EX_MEM, RegWrite_MEM_WB;
    output [1:0] ALU_SrcA_fwd, ALU_SrcB_fwd;

    wire [1:0] ALU_SrcA_fwd_temp2;
    wire [1:0] ALU_SrcB_fwd_temp2;

    wire hazard_1_rs;
    assign hazard_1_rs = (RegWrite_EX_MEM && (rd_EX_MEM == rs_ID_EX));

    wire hazard_1_rt;
    assign hazard_1_rt = (RegWrite_EX_MEM && (rd_EX_MEM == rt_ID_EX));

    wire harard_2_rs;
    assign hazard_2_rs = (RegWrite_MEM_WB && (rd_EX_MEM == rs_ID_EX));

    wire hazard_2_rt;
    assign hazard_2_rt = (RegWrite_MEM_WB && (rd_EX_MEM == rt_ID_EX));

    assign ALU_SrcA_fwd = hazard_1_rs ? 2'b10 : ALU_SrcA_fwd_temp2;
    assign ALU_SrcB_fwd = hazard_1_rt ? 2'b10 : ALU_SrcB_fwd_temp2;

    assign ALU_SrcA_fwd_temp2 = harard_2_rs ? 2'b01 : 2'b00;
    assign ALU_SrcB_fwd_temp2 = hazard_2_rt ? 2'b01 : 2'b00;

endmodule

// 0000 LW reg1, 2(reg2)
// 0004 LW reg4, 4(reg1)
// 0008 SUB reg6, reg3, reg5
// 0012 XOR reg8, reg7, reg6
// 0016 ORI reg9, reg10, 22
