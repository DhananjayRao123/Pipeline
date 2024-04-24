module pipeline (clk, rst_n); 

input clk, rst_n;
wire [31:0] instr;

wire [31:0]instr_out,snex,ex,A,B;
wire [8:0]control_signals_1;

wire [31:0]Fwd_mem;
wire [1:0]ALU_SrcA_fwd;
wire [1:0]ALU_SrcB_fwd;
wire [31:0]ALU_Out;
wire [31:0]MemData;
wire [31:0]MemOut;

wire stall, PC_write;
Hazard_detection H1 (.rs_IF_ID(IF_ID[25:21]), .rt_IF_ID(IF_ID[20:16]), .rt_ID_EX(ID_EX[157:153]), .MemRead_ID_EX(ID_EX[3]), .stall(stall), .PC_write(PC_write));
forwarding_unit f (.rd_EX_MEM(EX_MEM[40:36]), .rd_MEM_WB(MEM_WB[70:66]), .rs_ID_EX(ID_EX[162:158]), .rt_ID_EX(ID_EX[157:153]), .RegWrite_EX_MEM(EX_MEM[1]), .RegWrite_MEM_WB(MEM_WB[1]), .ALU_SrcA_fwd(ALU_SrcA_fwd), .ALU_SrcB_fwd(ALU_SrcB_fwd));

IF stage1 (clk, rst_n, instr, PC_write);

ID stage2 (
    .IF_ID(IF_ID),
    .rd_old(MEM_WB[70:66]),
    .reg_write_old(MEM_WB[1]),
    .clk(clk),
    .stall(stall),
    .write_data(Fwd_mem),

    .instr_out(instr_out),
    .snex(snex),
    .ex(ex),
    .A(A),
    .B(B),
    .control_signals(control_signals_1)   
);

EX stage3 (
    .A(ID_EX[72:41]),
    .B(ID_EX[40:9]),
    .F(ID_EX[142:137]),
    .snex(ID_EX[136:105]),
    .ex(ID_EX[136:105]),
    .Fwd_mem(Fwd_mem),
    .Fwd_wb(EX_MEM[35:4]),
    .ALU_SrcA_fwd(ALU_SrcA_fwd),
    .ALU_SrcB_ctrl(ID_EX[5:4]),
    .ALU_SrcB_fwd(ALU_SrcB_fwd),
    .ALUOp(control_signals_1[7:6]),
    .ALU_Out(ALU_Out)
 );

MEM Stage4(.data_address(EX_MEM[35:4]), .data(EX_MEM[72:41]), .MemRead(EX_MEM[3]), .MemWrite(EX_MEM[2]), .MemOut(MemOut));

assign Fwd_mem = MEM_WB[0] ? MEM_WB[65:34] : MEM_WB[33:2];
wire [4:0] destination;
assign destination = ID_EX[8] ? ID_EX[152:148] : ID_EX[157:153];

// Pipelined registers
reg [31:0] IF_ID;
reg [168:0] ID_EX;
reg [72:0] EX_MEM;
reg [70:0] MEM_WB;


always @(posedge clk, negedge rst_n)begin
    if(~rst_n) begin
        IF_ID <= 32'b0;
        ID_EX <= 169'b0;
        EX_MEM <= 73'b0;
        MEM_WB <= 71'b0;
    end
    else begin
        IF_ID <= instr;
        ID_EX <= {instr_out,snex, ex, A, B, control_signals_1};
        EX_MEM <= {ID_EX[40:9], destination, ALU_Out, ID_EX[3:0]};
        MEM_WB <= {EX_MEM[40:36], EX_MEM[65:34], MemOut, EX_MEM[1:0]};
    end
end


endmodule