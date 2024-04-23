module ALU_control(ALUOp, F, Operation);

input [1:0] ALUOp;
input [5:0] F;
output reg [3:0] Operation;

always @ (*)
begin
	Operation[0] = ALUOp[1] & (F[3] | F[0]);
	Operation[1] = !(ALUOp[1] & F[2]);
	Operation[2] = (!ALUOp[1] & ALUOp[0]) | (ALUOp[1] & F[1] & !ALUOp[0]);
	Operation[3] = 1'b0;
	if (ALUOp == 2'b11) Operation = 4'd1; // To accommodate the ORI instruction
end
 
endmodule
