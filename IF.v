module IF(clk, rst_n, instr, PC_write);
input clk, rst_n;
input PC_write;

output reg [31:0] instr;

reg [7:0] instr_mem [0:19];

initial begin
    instr_mem[0] = 8'h08;
    instr_mem[1] = 8'h41;
    instr_mem[2] = 8'h00;
    instr_mem[3] = 8'h02;
    
    instr_mem[4] = 8'h08;//0000 0000 0010 0001 0011 0000 0000 0010 
    instr_mem[5] = 8'h24;
    instr_mem[6] = 8'h00;
    instr_mem[7] = 8'h04;
    
    instr_mem[8] = 8'h00;
    instr_mem[9] = 8'h65;
    instr_mem[10] = 8'h30;
    instr_mem[11] = 8'h06;
    
    instr_mem[12] = 8'h00;
    instr_mem[13] = 8'hE6;
    instr_mem[14] = 8'h40;
    instr_mem[15] = 8'h00;

    instr_mem[16] = 8'h05;
    instr_mem[17] = 8'h49;
    instr_mem[18] = 8'h00;
    instr_mem[19] = 8'h16;
    
end

reg [31:0] PC; 
reg [31:0] PC_inc;
wire [31:0] PC_same;
wire [31:0] PC_next;

assign PC_next = PC_write ? PC_inc : PC;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin 
        PC <= 32'd0;
        PC_inc <= 32'd4;
        end
    else begin
        PC <= PC_next;
        PC_inc <= PC_next + 4;
    end
end

always @ (*) begin
    instr = {instr_mem[PC], instr_mem[PC+1], instr_mem[PC+2], instr_mem[PC+3]};    
end

endmodule
