module axi4_lite_uart_32_bit_slave (
    input aclk,
    input aresetn,
    // Write Address Channel
    input [31:0] awaddr_in,
    input [2:0] awprot_in,
    input awvalid,
    output awready_out,
    input awready_in,
    // Write Data Channel
    input [31:0] wdata_in,
    input [3:0] wstrb_in,
    input wvalid_in,
    output wready_out,
    input wready_in,
    // Write Response Channel
    output [1:0] bresp_out,
    output bvalid_out,
    input bready_in,
    // Read Address Channel
    input [31:0] araddr_in,
    input [2:0] arprot_in,
    input arvalid_in,
    output arready_out,
    input arready_in,
    // Read Data Channel
    output [31:0] rdata_out,
    output [1:0] rresp_out,
    output rvalid_out,
    input rready_in,
    input [31:0] rdata_in,
    // UART
    output tx,
    input rx
);

    axi4_lite_slave uut_slave_adapter(
        .aclk (aclk),
        .aresetn (aresetn),
        // Write Address Channel
        .awaddr_in (awaddr_in),
        .awprot_in (awprot_in),
        .awvalid_in (awvalid_in),
        .awready_out (awready_out),
        .awready_in (awready_in),
        // Write Data Channel
        .wdata_in (wdata_in),
        .wstrb_in (wstrb_in),
        .wvalid_in (wvalid_in),
        .wready_out (wready_out),
        .wready_in (wready_in),
        // Write Response Channel
        .bresp_out (bresp_out),
        .bvalid_out (bvalid_out),
        .bready_in (bready_in),
        // Read Address Channel
        .araddr_in (araddr_in),
        .arprot_in (arprot_in),
        .arvalid_in (arvalid_in),
        .arready_out (arready_out),
        .arready_in (arready_in),
        // Read Data Channel
        .rdata_out (rdata_out),
        .rresp_out (rresp_out),
        .rvalid_out (rvalid_out),
        .rready_in (rready_in),
        .rdata_in (rdata_in)
    );

    reg [1:0] address_uart;
    reg we, re;

    always @(*) begin
        if (awaddr_in[1:0] == 2'b00 || awaddr_in[1:0] == 2'b01 || awaddr_in[1:0] == 2'b10) begin
            address_uart = awaddr_in[1:0];
        end
        else begin
            if (araddr_in[1:0] == 2'b11) begin
                address_uart = araddr_in[1:0];
            end
        end
        we = (awready_in | wready_in);
        re = (arready_in);
    end

    uart_32_bit_top_design uut_slave(
        .clk (aclk),
        .rst (aresetn),
        .address (address_uart),
        .write_enable (we),
        .write_data (wdata_in),
        .read_enable (re),
        .read_data (rdata_out),
        .tx (tx),
        .rx (rx)
    );

endmodule