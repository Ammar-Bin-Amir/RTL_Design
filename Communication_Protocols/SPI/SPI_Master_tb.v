`timescale 1ns/1ns
`include "SPI_Master.v"

module spi_master_tb;
    
    reg clk;
    reg rst;
    // Chip Select
    reg en;
    wire cs;
    // Serial Clock
    wire sck;
    // Master Out Slave In
    reg [7:0] ext_command_in;
    reg [7:0] ext_address_in;
    reg [7:0] ext_data_in;
    wire mosi;
    // Master In Slave Out
    reg miso;
    wire [7:0] ext_data_out;

    spi_master uut (
        .clk (clk),
        .rst (rst),
        .en (en),
        .cs (cs),
        .sck (sck),
        .ext_command_in (ext_command_in),
        .ext_address_in (ext_address_in),
        .ext_data_in (ext_data_in),
        .mosi (mosi),
        .miso (miso),
        .ext_data_out (ext_data_out)
    );

    initial clk = 0;
    always #10 clk = ~clk;
    
    initial begin
        #10 rst = 1;
        #50 rst = 0;
        #50 ext_command_in = 8'ha5; ext_address_in = 8'h12; ext_data_in = 8'hed;
        #25 en = 1;
        #30 en = 0;
        #1500 ext_command_in = 8'h00; ext_address_in = 8'h34; ext_data_in = 8'hcb;
        #25 en = 1;
        #25 en = 0;
        #1500 ext_command_in = 8'hff; ext_address_in = 8'h67; ext_data_in = 8'h98;
        #30 en = 1;
        #30 en = 0;
        #1500 $finish;
    end
    
    initial begin
        $dumpfile("SPI_Master_tb.vcd");
        $dumpvars(0,spi_master_tb);
    end

endmodule