`timescale 1ns/1ns
`include "Handshaking_Slave.v"

module handshaking_slave_tb;
    
    reg clk,rst;
    reg [7:0] data_in;
    reg data_valid;
    reg ready;
    wire data_ready;

    handshaking_slave uut(clk,rst,data_in,data_valid,ready,data_ready);

    initial begin
        $dumpfile("Handshaking_Slave_tb.vcd");
        $dumpvars(0,handshaking_slave_tb);
    end

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        data_in = 8'b1101_0100;
        #10 rst = 0;
        #10 rst = 1;
        #10 rst = 0;
        #50 data_valid = 1;
        #100 ready = 1;
        #150 ready = 0;
        #200 data_valid = 0;
        #1000 $finish;
    end

endmodule