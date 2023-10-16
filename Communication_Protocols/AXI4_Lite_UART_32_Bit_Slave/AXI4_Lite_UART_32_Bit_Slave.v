module axi4_lite_uart_32_bit_slave (
    input aclk,
    input aresetn,
    // Write Address Channel
    input [31:0] awaddr_in,
    input [2:0] awprot_in,
    input awvalid,
    output awready,
    // Write Data Channel
    input [31:0] wdata_in,
    input [3:0] wstrb_in,
    input wvalid,
    output wready,
    // Write Response Channel
    output [1:0] bresp,
    output bvalid,
    input bready,
    // Read Address Channel
    input [31:0] araddr_in,
    input [2:0] arprot_in,
    input arvalid,
    output arready,
    // Read Data Channel
    output [31:0] rdata_out,
    output [1:0] rresp,
    output rvalid,
    input rready,
    input [31:0] rdata_in,
    // UART
    output tx,
    input rx
);

    axi4_lite_slave_adaptor uut_slave_adaptor(
        .aclk (aclk),
        .aresetn (aresetn),
        // Write Address Channel
        .awaddr_in (awaddr_in),
        .awprot_in (awprot_in),
        .awvalid_in (awvalid),
        .awready_out (awready),
        // Write Data Channel
        .wdata_in (wdata_in),
        .wstrb_in (wstrb_in),
        .wvalid_in (wvalid),
        .wready_out (wready),
        // Write Response Channel
        .bresp_out (bresp),
        .bvalid_out (bvalid),
        .bready_in (bready),
        // Read Address Channel
        .araddr_in (araddr_in),
        .arprot_in (arprot_in),
        .arvalid_in (arvalid),
        .arready_out (arready),
        // Read Data Channel
        .rdata_out (rdata_out),
        .rresp_out (rresp),
        .rvalid_out (rvalid),
        .rready_in (rready),
        .rdata_in (rdata_in)
    );

    reg [1:0] address_uart;
    reg we, re;
    reg rst;

    always @(*) begin
        if (awaddr_in[1:0] == 2'b00 || awaddr_in[1:0] == 2'b01 || awaddr_in[1:0] == 2'b10) begin
            address_uart = awaddr_in[1:0];
        end
        else begin
            if (araddr_in[1:0] == 2'b11) begin
                address_uart = araddr_in[1:0];
            end
        end
        we = (awvalid | wvalid);
        re = (arvalid);
        rst = ~aresetn;
    end

    uart_32_bit_top_design uut_slave(
        .clk (aclk),
        .rst (rst),
        .address (address_uart),
        .write_enable (we),
        .write_data (wdata_in),
        .read_enable (re),
        .read_data (rdata_out),
        .tx (tx),
        .rx (rx)
    );

endmodule