module EX (A, B, F, snex, ex, Fwd_mem, Fwd_wb, ALU_SrcA_fwd, ALU_SrcB_ctrl, ALU_SrcB_fwd, ALUOp, ALU_Out);

input [31:0] A, B, snex, ex, Fwd_mem, Fwd_wb;
input [5:0] F;

input [1:0] ALU_SrcA_fwd;
input [1:0] ALU_SrcB_ctrl;
input [1:0] ALU_SrcB_fwd;
input [1:0] ALUOp;

output [31:0] ALU_Out;

reg [31:0] ALU_Op1,ALU_Op2;
reg [31:0] MUX_temp;

always @(*)
begin
    case(ALU_SrcA_fwd)
        0: ALU_Op1 = A;
        1: ALU_Op1 = Fwd_mem ;
        2: ALU_Op1 = Fwd_wb ;
        // default: ALU_Op1 = 32'b0;
    endcase
end

always @(*)
begin
    case(ALU_SrcB_ctrl)
        0: MUX_temp = B;
        1: MUX_temp = ex;
        2: MUX_temp = snex;
        // default: ALU_Op2 = 32'b0;
    endcase
end

always @(*)
begin
    case(ALU_SrcB_fwd)
        0: ALU_Op2 = MUX_temp;
        1: ALU_Op2 = Fwd_mem;
        2: ALU_Op2 = Fwd_wb;
        // default: ALU_Op2 = 32'b0;
    endcase
end

ALU_Top ALU (ALUOp, F, ALU_Op1, ALU_Op2, ALU_Out, Zero);

endmodule

