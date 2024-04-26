module tb;

pipeline DUT (clk, rst_n);

reg clk, rst_n;

always #5 clk = ~clk;

initial begin

    $dumpfile("tb_pipe.vcd");
    $dumpvars;
    clk = 0;
    rst_n = 0;
    #7 rst_n = 1;
    #100 $finish;
end

endmodule
