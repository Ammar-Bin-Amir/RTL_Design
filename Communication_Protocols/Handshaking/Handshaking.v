// `include "Handshaking_Master.v"
// `include "Handshaking_Slave.v"

module handshaking_top_design (
    input clk,
    input rst,
    input [7:0] data_in,
    input ready,
    output [7:0] data_out,
    output data_valid,
    output data_ready
);

    handshaking_master uut_master(
        .clk (clk),
        .rst (rst),
        .data_in (data_in),
        .data_out (data_out),
        .data_valid (data_valid),
        .data_ready (data_ready)
    );

    handshaking_slave uut_slave(
        .clk (clk),
        .rst (rst),
        .data_in (data_out),
        .data_valid (data_valid),
        .ready (ready),
        .data_ready (data_ready)
    );
    
endmodule