module MEM (data_address, data, MemRead, MemWrite, MemOut);
    input [31:0] data_address, data;
    input MemRead, MemWrite;

    output reg [31:0] MemOut;

    reg [31:0] Mem[0:1023];

    always @(*)
    begin
        if(MemRead)
            MemOut = Mem[data_address];
        else
            MemOut = 32'b0;
    end

    always @(*)
    begin
        if(MemWrite)
            Mem[data_address] = data;
    end

endmodule