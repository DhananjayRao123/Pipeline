module register_file(clk, rs, rt, rd, A, B, write_data);
input [4:0] rs, rt, rd;
input reg_write;
input [31:0] write_data;
input clk;

output reg [31:0] A, B;

reg [31:0] register [0:15]; 

initial begin
    register[2] = 90;
    register[1] = 10;
    register[5] = 32'h000000A0;
    register[4] = 32'h000000B1;
    register[7] = 32'hBEFF556A;
    register[8] = 32'hFFEE7129;
    register[10] = 32'hFAFF7EF;
    register[11] = 32'hEBAF735D;
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
