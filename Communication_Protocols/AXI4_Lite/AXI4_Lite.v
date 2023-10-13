`include "AXI4_Lite_Master.v"
`include "AXI4_Lite_Slave.v"

module axi4_lite_top_design (
    input aclk,
    input aresetn,
    // Write Address Channel
    input [31:0] awaddr_in,
    output [31:0] awaddr_out,
    input [2:0] awprot_in,
    output [2:0] awprot_out,
    output awvalid,
    input awready_in,
    output awready_out,
    // Write Data Channel
    input [31:0] wdata_in,
    output [31:0] wdata_out,
    input [3:0] wstrb_in,
    output [3:0] wstrb_out,
    output wvalid,
    input wready_in,
    output wready_out,
    // Write Response Channel
    output [1:0] bresp,
    output bvalid,
    output bready,
    // Read Address Channel
    input [31:0] araddr_in,
    output [31:0] araddr_out,
    input [2:0] arprot_in,
    output [2:0] arprot_out,
    output arvalid,
    input arready_in,
    output arready_out,
    // Read Data Channel
    input [31:0] rdata_in,
    output [31:0] rdata_out,
    output [1:0] rresp,
    output rvalid,
    output rready
);
    
    axi4_lite_master uut_master(
        .aclk (aclk),
        .aresetn (aresetn),
        // Write Address Channel
        .awaddr_out (awaddr_out),
        .awprot_out (awprot_out),
        .awvalid_out (awvalid),
        .awready_in (awready_out),
        .awaddr_in (awaddr_in),
        .awprot_in (awprot_in),
        // Write Data Channel
        .wdata_out (wdata_out),
        .wstrb_out (wstrb_out),
        .wvalid_out (wvalid),
        .wready_in (wready_out),
        .wdata_in (wdata_in),
        .wstrb_in (wstrb_in),
        // Write Response Channel
        .bresp_in (bresp),
        .bvalid_in (bvalid),
        .bready_out (bready),
        // Read Address Channel
        .araddr_out (araddr_out),
        .arprot_out (arprot_out),
        .arvalid_out (arvalid),
        .arready_in (arready_out),
        .araddr_in (araddr_in),
        .arprot_in (arprot_in),
        // Read Data Channel
        .rdata_in (rdata_out),
        .rresp_in (rresp),
        .rvalid_in (rvalid),
        .rready_out (rready)
    );

    axi4_lite_slave uut_slave(
        .aclk (aclk),
        .aresetn (aresetn),
        // Write Address Channel
        .awaddr_in (awaddr_out),
        .awprot_in (awprot_out),
        .awvalid_in (awvalid),
        .awready_out (awready_out),
        .awready_in (awready_in),
        // Write Data Channel
        .wdata_in (wdata_out),
        .wstrb_in (wstrb_out),
        .wvalid_in (wvalid),
        .wready_out (wready_out),
        .wready_in (wready_in),
        // Write Response Channel
        .bresp_out (bresp),
        .bvalid_out (bvalid),
        .bready_in (bready),
        // Read Address Channel
        .araddr_in (araddr_out),
        .arprot_in (arprot_out),
        .arvalid_in (arvalid),
        .arready_out (arready_out),
        .arready_in (arready_in),
        // Read Data Channel
        .rdata_out (rdata_out),
        .rresp_out (rresp),
        .rvalid_out (rvalid),
        .rready_in (rready),
        .rdata_in (rdata_in)
    );

endmodule