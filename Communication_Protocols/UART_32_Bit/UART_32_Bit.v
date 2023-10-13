module uart_32_bit_top_design (
    input clk,
    input rst,
    input [1:0] address,
    input write_enable,
    input [31:0] write_data,
    input read_enable,
    output reg [31:0] read_data,
    output tx,
    input rx
);

    // Register Interface

    localparam BAUD_RATE = 2'b00;
    localparam TX_ENABLE = 2'b01;
    localparam TX_DATA = 2'b10;
    localparam RX_DATA = 3'b11;

    reg [31:0] baud_division;
    reg enable;
    reg [31:0] data_out;
    wire [31:0] data_in;

    always @(*) begin
        case (address)
            BAUD_RATE: begin
                if (write_enable) begin
                    baud_division = write_data;
                end
            end
            TX_ENABLE: begin
                if (write_enable) begin
                    enable = write_data[0];
                end
            end
            TX_DATA: begin
                if (write_enable) begin
                    data_out = write_data[31:0];
                end
            end
            RX_DATA: begin
                if (read_enable) begin
                    read_data = data_in;
                end
            end
            // default: 
        endcase
    end

    // Baud Rate Interface

    wire baud_tick;
    
    uart_32_bit_baud_rate uut_uart_32_bit_baud_rate(
        .clk (clk),
        .rst (rst),
        .baud_division (baud_division),
        .baud_tick (baud_tick)
    );

    // Transmitter Interface

    uart_32_bit_tx uut_uart_32_bit_tx(
        .clk (clk),
        .rst (rst),
        .en (enable),
        .baud_tick (baud_tick),
        .data (data_out),
        .tx (tx)
    );

    // Receiver Interface

    uart_32_bit_rx uut_uart_32_bit_rx(
        .clk (clk),
        .rst (rst),
        .baud_tick (baud_tick),
        .rx (rx),
        .data (data_in)
    );
    
endmodule