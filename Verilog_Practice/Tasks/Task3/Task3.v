/*

Design a One-Way Traffic Control System:
> On RESET every light would be LOW
> RED lights remains HIGH for 30s after that YELLOW light would be HIGH
> YELLOW lights remain HIGH for 3s after that GREEN light would be HIGH
> GREEN lights remain HIGH for 30s after that RED light would be HIGH

*/

module task3 (
    input clk,
    input rst,
    output reg red,
    output reg yellow,
    output reg green
);
    
    localparam IDLE = 2'b00;
    localparam RED = 2'b01;
    localparam YELLOW = 2'b10;
    localparam GREEN = 2'b11;

    reg [1:0] current_state, next_state;
    
    always @(posedge clk) begin
        if (rst) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    reg [4:0] count_red;

    always @(posedge clk) begin
        if (rst) begin
            count_red <= 0;
        end
        else begin
            if (count_red == 30) begin
                count_red <= 0;
            end
            else begin
                count_red <= count_red + 1;
            end
        end
    end

    reg [1:0] count_yellow;

    always @(posedge clk) begin
        if (rst) begin
            count_yellow <= 0;
        end
        else begin
            if (next_state == YELLOW) begin
                if (count_yellow == 3) begin
                    count_yellow <= 0;
                end
                else begin
                    count_yellow <= count_yellow + 1;
                end
            end
            else begin
                count_yellow <= 0;
            end
        end
    end

    reg [4:0] count_green;

    always @(posedge clk) begin
        if (rst) begin
            count_green <= 0;
        end
        else begin
            if (next_state == GREEN) begin
                if (count_green == 30) begin
                    count_green <= 0;
                end
                else begin
                    count_green <= count_green + 1;
                end
            end
            else begin
                count_green <= 0;
            end
        end
    end

    always @(*) begin
        case (current_state)
            IDLE: begin
                red = 0;
                yellow = 0;
                green = 0;
                next_state <= RED;
            end
            RED: begin
                red = 1;
                yellow = 0;
                green = 0;
                if (count_red == 30) begin
                    next_state = YELLOW;
                end
            end
            YELLOW: begin
                red = 1;
                yellow = 1;
                green = 0;
                if (count_yellow == 3) begin
                    next_state = GREEN;
                end
            end
            GREEN: begin
                red = 0;
                yellow = 0;
                green = 1;
                if (count_green == 30) begin
                    next_state = RED;
                end
            end
            default: next_state <= IDLE;
        endcase
    end

endmodule