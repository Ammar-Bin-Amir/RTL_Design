`include "SPI_Master.v"
`include "SPI_Slave.v"

module spi (
    input wire clk,
    input wire rst,
    input wire en,
    input wire [7:0] ext_command_in,
    input wire [7:0] ext_address_in,
    input wire [7:0] ext_data_in,
    output wire [7:0] ext_data_out
);
    
    wire cs;
    wire sck;
    wire mosi;
    wire miso;

    spi_master uut_master (
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

    spi_slave uut_slave (
        .clk (clk),
        .rst (rst),
        .cs (cs),
        .sck (sck),
        .mosi (mosi),
        .miso (miso)
    );

endmodule