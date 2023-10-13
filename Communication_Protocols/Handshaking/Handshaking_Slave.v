module handshaking_slave (
    input clk,
    input rst,
    input [7:0] data_in,
    input data_valid,
    input ready,
    output reg data_ready
);
    
    reg [7:0] data;

    always @(posedge clk) begin
        if (rst) begin
            data_ready <= 0;
            data <= 0;
        end
        else begin
            data_ready <= ready;
            if (data_ready && data_valid) begin
                data <= data_in;
            end
        end
    end

endmodule