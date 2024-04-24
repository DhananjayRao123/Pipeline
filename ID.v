module ID(
input [31:0] IF_ID,
input [4:0] rd_old,
input reg_write_old,
input clk,
input stall,
input [31:0] write_data,

output [31:0] instr_out,
output [31:0] snex,
output [31:0] ex,
output [31:0] A,B,
output [8:0] control_signals
);

parameter amt = 16;
assign snex = {{16{IF_ID[15]}}, IF_ID[15:0]};
assign ex = {{amt{1'b0}}, IF_ID[15:0]};

assign instr_out = IF_ID;

wire RegDst, MemRead, MemWrite, RegWrite, MemtoReg;
wire [1:0] ALUOp, ALUSrcB;
assign control_signals = stall ? 9'b0 : {RegDst, ALUOp, ALUOp, ALUSrcB, MemRead, MemWrite, RegWrite, MemtoReg};

control C (.opcode(IF_ID[31:26]), .RegDst(RegDst), .ALUOp(ALUOp), .ALUSrcB(ALUSrcB), .MemRead(MemRead), .MemWrite(MemWrite), .RegWrite(RegWrite), .MemtoReg(MemtoReg));
register_file R (.clk(clk), .rs(IF_ID[25:21]), .rt(IF_ID[20:16]), .rd(rd_old), .reg_write(reg_write_old), .A(A), .B(B), .write_data(write_data));

endmodule
