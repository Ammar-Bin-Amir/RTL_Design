`timescale 1ns/1ns

module axi4_lite_uart_32_bit_slave_tb;
    
    reg aclk;
    reg aresetn;
    // Write Address Channel
    reg [31:0] awaddr_in;
    wire [31:0] awaddr_out;
    reg [2:0] awprot_in;
    wire [2:0] awprot_out;
    wire awvalid;
    wire awready;
    // Write Data Channel
    reg [31:0] wdata_in;
    wire [31:0] wdata_out;
    reg [3:0] wstrb_in;
    wire [3:0] wstrb_out;
    wire wvalid;
    wire wready;
    // Write Response Channel
    wire [1:0] bresp;
    wire bvalid;
    wire bready;
    // Read Address Channel
    reg [31:0] araddr_in;
    wire [31:0] araddr_out;
    reg [2:0] arprot_in;
    wire [2:0] arprot_out;
    // Read Data Channel
    reg [31:0] rdata_in;
    wire [31:0] rdata_out;
    wire [1:0] rresp;
    wire rvalid;
    wire rready;
    // UART
    wire tx;
    reg rx;

    axi4_lite_master_adaptor uut_master(
        .aclk (aclk),
        .aresetn (aresetn),
        // Write Address Channel
        .awaddr_out (awaddr_out),
        .awprot_out (awprot_out),
        .awvalid_out (awvalid),
        .awready_in (awready),
        .awaddr_in (awaddr_in),
        .awprot_in (awprot_in),
        // Write Data Channel
        .wdata_out (wdata_out),
        .wstrb_out (wstrb_out),
        .wvalid_out (wvalid),
        .wready_in (wready),
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
        .arready_in (arready),
        .araddr_in (araddr_in),
        .arprot_in (arprot_in),
        // Read Data Channel
        .rdata_in (rdata_out),
        .rresp_in (rresp),
        .rvalid_in (rvalid),
        .rready_out (rready)
    );
    
    axi4_lite_uart_32_bit_slave uut(
        .aclk (aclk),
        .aresetn (aresetn),
        // Write Address Channel
        .awaddr_in (awaddr_out),
        .awprot_in (awprot_out),
        .awvalid (awvalid),
        .awready (awready),
        // Write Data Channel
        .wdata_in (wdata_out),
        .wstrb_in (wstrb_out),
        .wvalid (wvalid),
        .wready (wready),
        // Write Response Channel
        .bresp (bresp),
        .bvalid (bvalid),
        .bready (bready),
        // Read Address Channel
        .araddr_in (araddr_out),
        .arprot_in (arprot_out),
        .arvalid (arvalid),
        .arready (arready),
        // Read Data Channel
        .rdata_out (rdata_out),
        .rresp (rresp),
        .rvalid (rvalid),
        .rready (rready),
        .rdata_in (rdata_in),
        // UART
        .tx (tx),
        .rx (rx)
    );

    initial begin
        $dumpfile("AXI4_Lite_UART_32_Bit_Slave_Test.vcd");
        $dumpvars(0,axi4_lite_uart_32_bit_slave_tb);
    end

    initial aclk = 0;
    always #5 aclk = ~aclk;

    initial begin
        awprot_in = 0;
        wstrb_in = 4'b1111;
        aresetn = 1;
        #22 aresetn = 0;
        #128 aresetn = 1;
        #100 awaddr_in = 0; wdata_in = 130;
        #100 awaddr_in = 1; wdata_in = 1;
        #100 awaddr_in = 2; wdata_in = 32'b1111_0000_1011_0100_1010_0101_1001_0110;
        // Start
        #104800 rx = 0;
        // Byte 1
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 0;
        // Byte 2
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        // Byte 3
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        // Byte 4
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 0;
        #104800 rx = 0;
        #104800 rx = 0;
        // Stop
        #104800 rx = 1;
        // Idle
        #104800 rx = 1;
        #50 araddr_in = 3; rdata_in = 32'b1111_0000_1011_0100_1010_0101_1001_0110;
        #100000000 $finish;
    end

endmodule