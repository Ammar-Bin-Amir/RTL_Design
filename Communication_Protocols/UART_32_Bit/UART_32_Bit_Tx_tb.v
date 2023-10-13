`timescale 1ns/1ns
`include "UART_32_Bit_Tx.v"

module uart_32_bit_tx_tb;
    
    reg clk,rst,en;
    reg baud_tick;
    reg [31:0] data;
    wire tx;

    uart_32_bit_tx uut(clk,rst,en,baud_tick,data,tx);

    initial begin
        $dumpfile("UART_32_Bit_Tx_tb.vcd");
        $dumpvars(0,uart_32_bit_tx_tb);
    end

    initial clk = 0;
    always #25 clk = ~clk;

    initial baud_tick = 0;
    always #3250 baud_tick = ~baud_tick;
    
    initial begin
        data = 32'b0000_1111_0100_1011_0101_1010_0110_1001;
        #50 rst = 1; en = 0;
        #50 rst = 0;
        #100 en = 1;
        #500000 en = 0;
        #10000000 en = 1;
        #500000 en = 0;
        #100000000 $finish;
    end

endmodule