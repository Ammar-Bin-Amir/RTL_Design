`timescale 1ns/1ns
// `include "Handshaking.v"

module handshaking_test;
    
    reg clk;
    reg rst;
    reg [7:0] data_in;
    reg ready;
    wire [7:0] data_out;
    wire data_valid;
    wire data_ready;

    handshaking_top_design uut(clk,rst,data_in,ready,data_out,data_valid,data_ready);

    initial begin
        $dumpfile("Handshaking_Test.vcd");
        $dumpvars(0,handshaking_test);
    end

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        data_in = 8'b0101_1010;
        #10 rst = 0;
        #25 rst = 1;
        #50 rst = 0;
        #150 ready = 1;
        #175 ready = 0;
        #200 data_in = 8'b1010_0101;
        #225 ready = 1;
        #250 ready = 0;
        #1000 $finish;
    end

endmodule