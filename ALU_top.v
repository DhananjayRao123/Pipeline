module ALU_Top(ALUOp, F, in_1,in_2, ALUOut, Zero);
input [5:0] F;
input [1:0] ALUOp;
input [31:0] in_1, in_2;

output Zero;
output [31:0] ALUOut;
wire [3:0] op;

ALU_control A1 (.ALUOp(ALUOp), .F(F), .Operation(op));
ALU_MIPS A2 (in_1,in_2, Zero, ALUOut, op);

endmodule
