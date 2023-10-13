`timescale 1ns/1ns
`include "AXI4_Lite_Slave.v"

module axi4_lite_slave_tb;

    reg aclk;
    reg aresetn;
    // Write Address Channel
    reg [31:0] awaddr_in;
    reg [2:0] awprot_in;
    reg awvalid_in;
    wire awready_out;
    //// Input(s) for Driving Output(s) of Write Address Channel
    reg awready_in;
    // Write Data Channel
    reg [31:0] wdata_in;
    reg [3:0] wstrb_in;
    reg wvalid_in;
    wire wready_out;
    //// Input(s) for Driving Output(s) of Write Data Channel
    reg wready_in;
    // Write Response Channel
    wire [1:0] bresp_out;
    wire bvalid_out;
    reg bready_in;
    // Read Address Channel
    reg [31:0] araddr_in;
    reg [2:0] arprot_in;
    reg arvalid_in;
    wire arready_out;
    //// Input(s) for Driving Output(s) of Read Address Channel
    reg arready_in;
    // Read Data Channel
    wire [31:0] rdata_out;
    wire [1:0] rresp_out;
    wire rvalid_out;
    reg rready_in;
    //// Input(s) for Driving Output(s) of Read Data Channel
    reg [31:0] rdata_in;

    axi4_lite_slave uut(
        aclk,aresetn,
        // Write Address Channel
        awaddr_in,awprot_in,awvalid_in,awready_out,awready_in,
        // Write Data Channel
        wdata_in,wstrb_in,wvalid_in,wready_out,wready_in,
        // Write Response Channel
        bresp_out,bvalid_out,bready_in,
        // Read Address Channel
        araddr_in,arprot_in,arvalid_in,arready_out,arready_in,
        // Read Data Channel
        rdata_out,rresp_out,rvalid_out,rready_in,rdata_in
    );

    initial begin
        $dumpfile("AXI4_Lite_Slave_tb.vcd");
        $dumpvars(0,axi4_lite_slave_tb);
    end

    initial aclk = 0;
    always #5 aclk = ~aclk;
    
    initial begin
        awaddr_in = 16;
        awprot_in = 4;
        wdata_in = 32'b1111_0000_1011_0100_1010_0101_1001_0110;
        wstrb_in = 4'b1011;
        araddr_in = 16;
        arprot_in = 4;
        rdata_in = 32'b1111_0000_1011_0100_1010_0101_1001_0110;
        #7 aresetn = 0;
        #8 aresetn = 1;
        #50 awvalid_in = 1; wvalid_in = 1; arvalid_in = 1;
        #50 awready_in = 1; wready_in = 1; arready_in = 1; rready_in = 1;
        #100 bready_in = 1;
        #50 awvalid_in = 0; awready_in = 0; wvalid_in = 0; wready_in = 0; bready_in = 0; arvalid_in = 0; arready_in = 0; rready_in = 0;
        #1000 $finish;
    end
    
endmodule