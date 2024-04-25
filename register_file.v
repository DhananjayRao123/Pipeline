module register_file(clk, rs, rt, rd, A, B, write_data, reg_write);
input [4:0] rs, rt, rd;
input reg_write;
input [31:0] write_data;
input clk;

output reg [31:0] A, B;

reg [31:0] register [0:15]; 

initial begin
//     //reg2 = 6 reg4 = 0E311
    // reg5 = 964EB reg7 = 964EA
    // reg8 = 113D4 reg10 = 1230B
    register[2] = 32'h6;
    register[1] = 32'h0E311;
    register[5] = 32'h964EB;
    register[4] = 32'h964EA;
    register[7] = 32'h113D4;
    register[8] = 32'h1230B;
    register[10] = 32'h1230B;
    register[11] = 32'h1230B;
    //make others 0
    register[0] = 0;
    register[3] = 0;
    register[6] = 0;
    register[9] = 0;
    register[12] = 0;
    register[13] = 0;
    register[14] = 0;
    register[15] = 0;
end

always @ (*) begin
    A = register[rs];
    B = register[rt];
end

always @(negedge clk) begin
    if(reg_write) 
        register[rd] = write_data;
end

endmodule
