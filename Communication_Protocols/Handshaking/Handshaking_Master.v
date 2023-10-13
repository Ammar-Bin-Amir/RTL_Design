module handshaking_master (
    input clk,
    input rst,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg data_valid,
    input data_ready
);
    
    always @(posedge clk) begin
        if (rst) begin
            data_valid <= 0;
        end
        else begin
            data_out <= data_in;
            if (data_out != 0) begin
                data_valid <= 1;
                if (data_ready) begin
                    data_valid <= 0;
                end
            end
        end
    end

endmodule