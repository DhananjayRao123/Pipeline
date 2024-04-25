module register_file(clk, rs, rt, rd, A, B, write_data, reg_write);
input [4:0] rs, rt, rd;
input reg_write;
input [31:0] write_data;
input clk;

output reg [31:0] A, B;

reg [31:0] register [0:15]; 

initial begin
    // //initialize register file
    // reg2 = 6 reg4 = 0E311
    // reg5 = 964EB reg7 = 964DA
    // reg8 = 113E4 reg10 = 1230B

    register[2] = 32'h00000006;
    register[4] = 32'h0000E311;
    register[5] = 32'h000964EB;
    register[7] = 32'h000964DA;
    register[8] = 32'h000113E4;
    register[10] = 32'h0001230B;
    //make others 0
    register[1] = 1;
    register[11] = 0;
    register[14] = 0;
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
