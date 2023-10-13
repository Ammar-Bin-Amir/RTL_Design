`timescale 1ns/1ns
`include "UART_32_Bit.v"

module uart_32_bit_test;
    
    reg clk;
    reg rst;
    reg [1:0] address;
    reg write_enable;
    reg [31:0] write_data;
    reg read_enable;
    wire [31:0] read_data;
    wire tx;
    reg rx;

    uart_32_bit_top_design uut(clk,rst,address,write_enable,write_data,read_enable,read_data,tx,rx);

    initial begin
        $dumpfile("UART_32_Bit_Test.vcd");
        $dumpvars(0,uart_32_bit_test);
    end

    initial clk = 0;
    always #25 clk = ~clk;

    initial begin
        rst = 1;
        #100 rst = 0;
        // Baud Rate
        #100 address = 0;
        #100 write_data = 130;
        #100 write_enable = 1;
        #100 write_enable = 0;
        // Enable
        #100 address = 1;
        #100 write_data = 1;
        #100 write_enable = 1;
        // Write
        #100 address = 2;
        #100 write_data = 32'b0000_1111_0100_1011_0101_1010_0110_1001;
        #100 address = 1;
        #100 write_data = 0;
        #100 write_enable = 1;
        // Read
        #100 address = 3;
        #100 write_enable = 1;
        #100 write_data = 32'b0000_1111_0100_1011_0101_1010_0110_1001;
        // Start
        #104800 rx = 0;
        // Byte 1
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 0;
        // Byte 2
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        // Byte 3
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        // Byte 4
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 0;
        #104800 rx = 0;
        #104800 rx = 0;
        // Stop
        #104800 rx = 1;
        // Idle
        #104800 rx = 1;
        #1000000 read_enable = 1;
        #100000000 $finish;
    end

endmodule