module control (
    input [5:0] opcode,

    // EX Signals
    output reg RegDst,
    output reg [1:0] ALUOp,
    output reg [1:0] ALUSrc,
    // MEM Signals
    output reg MemRead,
    output reg MemWrite,
    // WB Signals
    output reg RegWrite, 
    output reg MemtoReg
);

always @ (*) begin
    case(opcode)
        6'b000000: begin // SUB
            RegDst = 1'b1; // rd
            ALUOp = 2'b10;
            ALUSrc = 2'b00;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            MemtoReg = 1'b0;
        end
        6'b000001: begin // ORI
            RegDst = 1'b0; // rt
            ALUOp = 2'b11;
            ALUSrc = 2'b01;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            MemtoReg = 1'b0;
        end
        6'b000010: begin // LW
            RegDst = 1'b0;
            ALUOp = 2'b11;
            ALUSrc = 2'b10;
            MemRead = 1'b1;
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            MemtoReg = 1'b1;
        end
        6'b000011: begin // SW
            RegDst = 1'b0;
            ALUOp = 2'b11;
            ALUSrc = 2'b10;
            MemRead = 1'b0;
            MemWrite = 1'b1;
            RegWrite = 1'b0;
            MemtoReg = 1'b0;
        end
        default: begin
            RegDst = 1'b0;
            ALUOp = 2'b00;
            ALUSrc = 1'b0;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            RegWrite = 1'b0;
            MemtoReg = 1'b0;
        end
    endcase
end

endmodule
