`timescale 1ns/1ns

module axi4_lite_uart_32_bit_slave_tb;
    
    reg aclk;
    reg aresetn;
    // Write Address Channel
    reg [31:0] awaddr_in;
    reg [2:0] awprot_in;
    reg awvalid_in;
    wire awready_out;
    reg awready_in;
    // Write Data Channel
    reg [31:0] wdata_in;
    reg [3:0] wstrb_in;
    reg wvalid_in;
    wire wready_out;
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
    reg arready_in;
    // Read Data Channel
    wire [31:0] rdata_out;
    wire [1:0] rresp_out;
    wire rvalid_out;
    reg rready_in;
    reg [31:0] rdata_in;
    // UART
    wire tx;
    reg rx;

    wire [31:0] awaddr_out;
    wire [2:0] awprot_out;
    wire awvalid_out;
    wire [31:0] wdata_out;
    wire [3:0] wstrb_out;
    wire wvalid_out;
    wire bready_out;
    wire [31:0] araddr_out;
    wire arvalid_out;
    wire rready_out;

    axi4_lite_master uut_master(
        .aclk (aclk),
        .aresetn (aresetn),
        // Write Address Channel
        .awaddr_out (awaddr_out),
        .awprot_out (awprot_out),
        .awvalid_out (awvalid_out),
        .awready_in (awready_out),
        .awaddr_in (awaddr_in),
        .awprot_in (awprot_in),
        // Write Data Channel
        .wdata_out (wdata_out),
        .wstrb_out (wstrb_out),
        .wvalid_out (wvalid_out),
        .wready_in (wready_out),
        .wdata_in (wdata_in),
        .wstrb_in (wstrb_in),
        // Write Response Channel
        .bresp_in (bresp_out),
        .bvalid_in (bvalid_out),
        .bready_out (bready_out),
        // Read Address Channel
        .araddr_out (araddr_out),
        .arprot_out (awprot_out),
        .arvalid_out (arvalid_out),
        .arready_in (arready_in),
        .araddr_in (araddr_in),
        .arprot_in (awprot_in),
        // Read Data Channel
        .rdata_in (rdata_out),
        .rresp_in (rresp_out),
        .rvalid_in (rvalid_out),
        .rready_out (rready_out)
    );
    
    axi4_lite_uart_32_bit_slave uut(
        aclk,
        aresetn,
        // Write Address Channel
        awaddr_out,
        awprot_out,
        awvalid_in,
        awready_out,
        awready_in,
        // Write Data Channel
        wdata_out,
        wstrb_out,
        wvalid_in,
        wready_out,
        wready_in,
        // Write Response Channel
        bresp_out,
        bvalid_out,
        bready_in,
        // Read Address Channel
        araddr_in,
        awprot_in,
        arvalid_in,
        arready_out,
        arready_in,
        // Read Data Channel
        rdata_out,
        rresp_out,
        rvalid_out,
        rready_in,
        rdata_in,
        // UART
        tx,
        rx
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
        #50 awaddr_in = 0; wdata_in = 130;
        #50 awvalid_in = 1; wvalid_in = 1;
        #50 awready_in = 1; wready_in = 1;
        #50 awvalid_in = 0; awready_in = 0; wvalid_in = 0; wready_in = 0;
        #50 awaddr_in = 1; wdata_in = 1;
        #50 awvalid_in = 1; wvalid_in = 1;
        #50 awready_in = 1; wready_in = 1;
        #50 awvalid_in = 0; awready_in = 0; wvalid_in = 0; wready_in = 0;
        #50 awaddr_in = 2; wdata_in = 32'b1111_0000_1011_0100_1010_0101_1001_0110;;
        #50 awvalid_in = 1; wvalid_in = 1;
        #50 awready_in = 1; wready_in = 1;
        #50 awvalid_in = 0; awready_in = 0; wvalid_in = 0; wready_in = 0;
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
        #50 araddr_in = 3; rdata_in = 32'b1111_0000_1011_0100_1010_0101_1001_0110;;
        #50 arvalid_in = 1;
        #50 arready_in = 1; rready_in = 1;
        #50 arvalid_in = 0; arready_in = 0; rready_in = 0;

        // awaddr_in = 0;
        // awprot_in = 3;
        // wdata_in = 130;
        // wstrb_in = 4'b1111;
        // araddr_in = 32;
        // arprot_in = 5;
        // rdata_in = 32'b1111_0000_1011_0100_1010_0101_1001_0110;
        // aresetn = 1;
        // #22 aresetn = 0;
        // #48 aresetn = 1;
        // #40 awready_in = 1;
        // #40 wready_in = 1;
        // #40 arready_in = 1;
        // #50 awready_in = 0; wready_in = 0; arready_in = 0;
        // #30 awready_in = 1;
        // #10 wready_in = 1;
        // #10 arready_in = 1;
        // // Start
        // #104800 rx = 0;
        // // Byte 1
        // #104800 rx = 1;
        // #104800 rx = 0;
        // #104800 rx = 0;
        // #104800 rx = 1;
        // #104800 rx = 0;
        // #104800 rx = 1;
        // #104800 rx = 1;
        // #104800 rx = 0;
        // // Byte 2
        // #104800 rx = 0;
        // #104800 rx = 1;
        // #104800 rx = 0;
        // #104800 rx = 1;
        // #104800 rx = 1;
        // #104800 rx = 0;
        // #104800 rx = 1;
        // #104800 rx = 0;
        // // Byte 3
        // #104800 rx = 1;
        // #104800 rx = 1;
        // #104800 rx = 0;
        // #104800 rx = 1;
        // #104800 rx = 0;
        // #104800 rx = 0;
        // #104800 rx = 1;
        // #104800 rx = 0;
        // // Byte 4
        // #104800 rx = 1;
        // #104800 rx = 1;
        // #104800 rx = 1;
        // #104800 rx = 1;
        // #104800 rx = 0;
        // #104800 rx = 0;
        // #104800 rx = 0;
        // #104800 rx = 0;
        // // Stop
        // #104800 rx = 1;
        // // Idle
        // #104800 rx = 1;
        #100000000 $finish;
    end

endmodule