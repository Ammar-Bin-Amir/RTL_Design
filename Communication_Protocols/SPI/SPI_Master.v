module spi_master (
    input wire clk,
    input wire rst,
    // Chip Select
    input wire en,
    output reg cs,
    // Serial Clock
    output reg sck,
    // Master Out Slave In
    input wire [7:0] ext_command_in,
    input wire [7:0] ext_address_in,
    input wire [7:0] ext_data_in,
    output reg mosi,
    // Master In Slave Out
    input wire miso,
    output wire [7:0] ext_data_out
);
    
    // Serial Clock

    reg clock_count;

    always @(posedge clk) begin
        if (rst) begin
            clock_count <= 0;
        end
        else begin
            if ((current_state == ENABLE) || (current_state == DATA)) begin
                clock_count <= clock_count + 1;
            end
            else begin
                clock_count <= 0;
            end
        end
    end

    // Master Out Slave In

    reg [23:0] data_save;
    reg [23:0] data_count;
    reg data_end;

    always @(posedge clk) begin
        if (rst) begin
            data_save <= 0;
            data_count <= 0;
            data_end <= 0;
        end
        else begin
            if (current_state == DATA) begin
                if (sck == 1) begin
                    data_save <= {data_save[22:0],1'b0};
                    if (data_count == 23) begin
                        data_count <= 0;
                        data_end <= 1;
                    end
                    else begin
                        data_count <= data_count + 1;
                        data_end <= 0;
                    end
                end
                else begin
                    data_save <= data_save;
                    data_count <= data_count;
                    data_end <= 0;
                end
            end
            else begin
                if (ext_command_in == 8'h00) begin
                    data_save <= {ext_command_in,ext_address_in,ext_data_in};
                    data_count <= 0;
                    data_end <= 0;
                end
                else begin
                    data_save <= {ext_command_in,ext_address_in,8'h00};
                    data_count <= 0;
                    data_end <= 0;
                end
            end
        end
    end

    // Master In Slave Out

    reg [7:0] data_in;

    always @(posedge clk) begin
        if (rst) begin
            data_in <= 0;
        end
        else begin
            if (current_state == DATA) begin
                if (sck == 0) begin
                    if ((data_count >= 16) && (data_count <= 23)) begin
                        data_in <= {data_in[6:0],miso};
                    end
                    else begin
                        data_in <= data_in;
                    end
                end
                else begin
                    data_in <= data_in;
                end
            end
            else begin
                
            end
        end
    end

    assign ext_data_out = data_in;
    
    // Finite State Machine

    localparam IDLE = 2'b00;
    localparam ENABLE = 2'b01;
    localparam DATA = 2'b10;

    reg [1:0] current_state, next_state;

    always @(posedge clk) begin
        if (rst) begin
            current_state <= 0;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        if (rst) begin
            next_state = 0;
        end
        else begin
            case (current_state)
                IDLE: begin
                    cs = 1;
                    sck = 1;
                    mosi = 0;
                    if (en == 1'b1) begin
                        next_state = ENABLE;
                    end
                end
                ENABLE: begin
                    cs = 0;
                    sck = ~clock_count;
                    mosi = 0;
                    next_state = DATA;
                end
                DATA: begin
                    cs = 0;
                    sck = ~clock_count;
                    mosi = data_save[23];
                    if (data_end == 1'b1) begin
                        sck = 1;
                        next_state = IDLE;
                    end
                end
                default: next_state = IDLE;
            endcase
        end
    end

endmodule