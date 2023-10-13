module uart_32_bit_tx (
    input clk,
    input rst,
    input en,
    input baud_tick,
    input [31:0] data,
    output reg tx
);

    localparam IDLE = 0;
    localparam START = 1;
    localparam DATA_BIT_0 = 2;
    localparam DATA_BIT_1 = 3;
    localparam DATA_BIT_2 = 4;
    localparam DATA_BIT_3 = 5;
    localparam DATA_BIT_4 = 6;
    localparam DATA_BIT_5 = 7;
    localparam DATA_BIT_6 = 8;
    localparam DATA_BIT_7 = 9;
    localparam DATA_BIT_8 = 10;
    localparam DATA_BIT_9 = 11;
    localparam DATA_BIT_10 = 12;
    localparam DATA_BIT_11 = 13;
    localparam DATA_BIT_12 = 14;
    localparam DATA_BIT_13 = 15;
    localparam DATA_BIT_14 = 16;
    localparam DATA_BIT_15 = 17;
    localparam DATA_BIT_16 = 18;
    localparam DATA_BIT_17 = 19;
    localparam DATA_BIT_18 = 20;
    localparam DATA_BIT_19 = 21;
    localparam DATA_BIT_20 = 22;
    localparam DATA_BIT_21 = 23;
    localparam DATA_BIT_22 = 24;
    localparam DATA_BIT_23 = 25;
    localparam DATA_BIT_24 = 26;
    localparam DATA_BIT_25 = 27;
    localparam DATA_BIT_26 = 28;
    localparam DATA_BIT_27 = 29;
    localparam DATA_BIT_28 = 30;
    localparam DATA_BIT_29 = 31;
    localparam DATA_BIT_30 = 32;
    localparam DATA_BIT_31 = 33;
    localparam STOP = 34;

    reg [5:0] current_state, next_state;

    always @(posedge clk) begin
        if (rst) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    reg [3:0] count_16 = 0;

    always @(*) begin
        case (current_state)
            IDLE: begin
                tx = 1;
                if (en) begin
                    count_16 = 0;
                    next_state = START;
                end
            end
            START: begin
                if (baud_tick) begin
                    tx = 0;
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_0;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_0: begin
                if (baud_tick) begin
                    tx = data[0];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_1;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_1: begin
                if (baud_tick) begin
                    tx = data[1];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_2;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_2: begin
                if (baud_tick) begin
                    tx = data[2];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_3;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_3: begin
                if (baud_tick) begin
                    tx = data[3];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_4;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_4: begin
                if (baud_tick) begin
                    tx = data[4];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_5;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_5: begin
                if (baud_tick) begin
                    tx = data[5];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_6;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_6: begin
                if (baud_tick) begin
                    tx = data[6];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_7;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_7: begin
                if (baud_tick) begin
                    tx = data[7];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_8;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_8: begin
                if (baud_tick) begin
                    tx = data[8];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_9;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_9: begin
                if (baud_tick) begin
                    tx = data[9];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_10;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_10: begin
                if (baud_tick) begin
                    tx = data[10];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_11;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_11: begin
                if (baud_tick) begin
                    tx = data[11];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_12;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_12: begin
                if (baud_tick) begin
                    tx = data[12];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_13;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_13: begin
                if (baud_tick) begin
                    tx = data[13];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_14;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_14: begin
                if (baud_tick) begin
                    tx = data[14];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_15;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_15: begin
                if (baud_tick) begin
                    tx = data[15];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_16;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_16: begin
                if (baud_tick) begin
                    tx = data[16];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_17;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_17: begin
                if (baud_tick) begin
                    tx = data[17];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_18;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_18: begin
                if (baud_tick) begin
                    tx = data[18];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_19;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_19: begin
                if (baud_tick) begin
                    tx = data[19];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_20;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_20: begin
                if (baud_tick) begin
                    tx = data[20];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_21;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_21: begin
                if (baud_tick) begin
                    tx = data[21];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_22;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_22: begin
                if (baud_tick) begin
                    tx = data[22];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_23;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_23: begin
                if (baud_tick) begin
                    tx = data[23];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_24;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_24: begin
                if (baud_tick) begin
                    tx = data[24];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_25;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_25: begin
                if (baud_tick) begin
                    tx = data[25];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_26;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_26: begin
                if (baud_tick) begin
                    tx = data[26];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_27;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_28: begin
                if (baud_tick) begin
                    tx = data[28];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_29;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_29: begin
                if (baud_tick) begin
                    tx = data[29];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_30;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_30: begin
                if (baud_tick) begin
                    tx = data[30];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = DATA_BIT_31;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_31: begin
                if (baud_tick) begin
                    tx = data[31];
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = STOP;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            STOP: begin
                if (baud_tick) begin
                    tx = 1;
                    if (count_16 == 15) begin
                        count_16 = 0;
                        next_state = IDLE;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule