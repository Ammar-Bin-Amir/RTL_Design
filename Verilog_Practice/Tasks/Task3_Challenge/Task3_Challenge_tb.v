`timescale 1ns/1ns
`include "Task3_Challenge.v"

module task3_challenge_tb;
    
    reg clk;
    reg rst;
    wire red;
    wire green;

    task3_challenge uut(clk,rst,red,yellow,green);

    initial begin
        $dumpfile("Task3_Challenge_tb.vcd");
        $dumpvars(0,task3_challenge_tb);
    end

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        #10 rst = 1;
        #50 rst = 0;
        #5000 $finish;
    end

endmodule