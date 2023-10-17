/*

CHALLENGE: Perform Task3 using Single Counter
=============================================

Design a One-Way Traffic Control System:
> On RESET every light would be LOW
> RED lights remains HIGH for 30s after that YELLOW light would be HIGH
> YELLOW lights remain HIGH for 3s after that GREEN light would be HIGH
> GREEN lights remain HIGH for 30s after that RED light would be HIGH

*/

module task3_challenge (
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
                next_state = YELLOW;
            end
            YELLOW: begin
                red = 1;
                yellow = 1;
                green = 0;
                next_state = GREEN;
            end
            GREEN: begin
                red = 0;
                yellow = 0;
                green = 1;
                next_state = RED;
            end
            default: next_state <= IDLE;
        endcase
    end

endmodule