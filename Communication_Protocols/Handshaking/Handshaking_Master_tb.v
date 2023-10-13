`timescale 1ns/1ns
`include "Handshaking_Master.v"

module handshaking_master_tb;
    
    reg clk,rst;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire data_valid;
    reg data_ready;

    handshaking_master uut(clk,rst,data_in,data_out,data_valid,data_ready);

    initial begin
        $dumpfile("Handshaking_Master_tb.vcd");
        $dumpvars(0,handshaking_master_tb);
    end

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        data_in = 8'b1001_0110;
        #10 rst = 0;
        #10 rst = 1;
        #10 rst = 0;
        #50 data_ready = 1;
        #75 data_ready = 0;
        #95 data_in = 8'b0110_1001;
        #1000 $finish;
    end

endmodule