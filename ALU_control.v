module ALU_control(ALUOp, F, Operation);

input [1:0] ALUOp;
input [5:0] F;
output reg [3:0] Operation;

always @ (*)
begin
	// Operation[0] = ALUOp[1] & (F[3] | F[0]);
	// Operation[1] = !(ALUOp[1] & F[2]);
	// Operation[2] = (!ALUOp[1] & ALUOp[0]) | (ALUOp[1] & F[1] & !ALUOp[0]);
	// Operation[3] = 1'b0;
	// if (ALUOp == 2'b11) Operation = 4'd1; // To accommodate the ORI instruction

	case (ALUOp)
		2'b00: Operation = 4'b0010; // LW and SW
		2'b10:begin
			case (F)
				6'b000010: Operation = 4'b0010; // ADD
				6'b000000: Operation = 4'b0000; // XOR
				6'b000110: Operation = 4'b0110; // SUB
            endcase
			end // R Type
		2'b11: Operation = 4'b0001; // ORI
		default: Operation = 4'b0000;
	endcase
end
 
endmodule
