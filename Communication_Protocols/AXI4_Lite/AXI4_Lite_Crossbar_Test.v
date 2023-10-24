`timescale 1ns/1ns
`include "AXI4_Lite_Crossbar.v"

module axi4_lite_crossbar_tb;
    
    reg aclk;
    reg aresetn;
    // Write Address Channel
    // Master 1
    reg [31:0] awaddr_in_m1;
    reg [2:0] awprot_in_m1;
    reg awvalid_in_m1;
    // Master 2
    reg [31:0] awaddr_in_m2;
    reg [2:0] awprot_in_m2;
    reg awvalid_in_m2;
    // Slave 1
    wire [31:0] awaddr_out_s1;
    wire [2:0] awprot_out_s1;
    wire awvalid_out_s1;
    // Slave 2
    wire [31:0] awaddr_out_s2;
    wire [2:0] awprot_out_s2;
    wire awvalid_out_s2;
    // Write Data Channel
    // Master 1
    reg [31:0] wdata_in_m1;
    reg [3:0] wstrb_in_m1;
    reg wvalid_in_m1;
    // Master 2
    reg [31:0] wdata_in_m2;
    reg [3:0] wstrb_in_m2;
    reg wvalid_in_m2;
    // Slave 1
    wire [31:0] wdata_out_s1;
    wire [3:0] wstrb_out_s1;
    wire wvalid_out_s1;
    // Slave 2
    wire [31:0] wdata_out_s2;
    wire [3:0] wstrb_out_s2;
    wire wvalid_out_s2;
    // Write Response Channel
    // Master 1
    wire [1:0] bresp_out_m1;
    wire bvalid_out_m1;
    // Master 2
    wire [1:0] bresp_out_m2;
    wire bvalid_out_m2;
    // Slave 1
    reg [1:0] bresp_in_s1;
    reg bvalid_in_s1;
    // Slave 2
    reg [1:0] bresp_in_s2;
    reg bvalid_in_s2;
    // Read Address Channel
    // Master 1
    reg [31:0] araddr_in_m1;
    reg [2:0] arprot_in_m1;
    reg arvalid_in_m1;
    // Master 2
    reg [31:0] araddr_in_m2;
    reg [2:0] arprot_in_m2;
    reg arvalid_in_m2;
    // Slave 1
    wire [31:0] araddr_out_s1;
    wire [2:0] arprot_out_s1;
    wire arvalid_out_s1;
    // Slave 2
    wire [31:0] araddr_out_s2;
    wire [2:0] arprot_out_s2;
    wire arvalid_out_s2;
    // Read Data Channel
    // Master 1
    wire [31:0] rdata_out_m1;
    wire rvalid_out_m1;
    wire [1:0] rresp_out_m1;
    // Master 2
    wire [31:0] rdata_out_m2;
    wire rvalid_out_m2;
    wire [1:0] rresp_out_m2;
    // Slave 1
    reg [31:0] rdata_in_s1;
    reg rvalid_in_s1;
    reg [1:0] rresp_in_s1;
    // Slave 2
    reg [31:0] rdata_in_s2;
    reg rvalid_in_s2;
    reg [1:0] rresp_in_s2;

    axi4_lite_crossbar uut(
        aclk, aresetn,
        awaddr_in_m1, awprot_in_m1, awvalid_in_m1,
        awaddr_in_m2, awprot_in_m2, awvalid_in_m2,
        awaddr_out_s1, awprot_out_s1, awvalid_out_s1,
        awaddr_out_s2, awprot_out_s2, awvalid_out_s2,
        wdata_in_m1, wstrb_in_m1, wvalid_in_m1,
        wdata_in_m2, wstrb_in_m2, wvalid_in_m2,
        wdata_out_s1, wstrb_out_s1, wvalid_out_s1,
        wdata_out_s2, wstrb_out_s2, wvalid_out_s2,
        bresp_out_m1, bvalid_out_m1,
        bresp_out_m2, bvalid_out_m2,
        bresp_in_s1, bvalid_in_s1,
        bresp_in_s2, bvalid_in_s2,
        araddr_in_m1, arprot_in_m1, arvalid_in_m1,
        araddr_in_m2, arprot_in_m2, arvalid_in_m2,
        araddr_out_s1, arprot_out_s1, arvalid_out_s1,
        araddr_out_s2, arprot_out_s2, arvalid_out_s2,
        rdata_out_m1, rvalid_out_m1, rresp_out_m1,
        rdata_out_m2, rvalid_out_m2, rresp_out_m2,
        rdata_in_s1, rvalid_in_s1, rresp_in_s1,
        rdata_in_s2, rvalid_in_s2, rresp_in_s2
    );

    initial begin
        $dumpfile("AXI4_Lite_Crossbar_Test.vcd");
        $dumpvars(0,axi4_lite_crossbar_tb);
    end

    initial aclk = 0;
    always #5 aclk = ~aclk;

    initial begin
        aresetn = 0;
        #10 aresetn = 1;
        // M1 ---> S1
        #30
        awaddr_in_m1 = 32'h0000_2000;
        awprot_in_m1 = 2;
        awvalid_in_m1 = 1;
        wdata_in_m1 = 32'h1234_5678;
        wstrb_in_m1 = 2;
        wvalid_in_m1 = 1;
        bresp_in_s1 = 2;
        bvalid_in_s1 = 1;
        araddr_in_m1 = 32'h0000_2fff;
        arprot_in_m1 = 2;
        arvalid_in_m1 = 1;
        rdata_in_s1 = 32'h90ab_cdef;
        rvalid_in_s1 = 1;
        rresp_in_s1 = 2;
        // M1 ---> S2
        #30
        awaddr_in_m1 = 32'h0000_3000;
        awprot_in_m1 = 3;
        awvalid_in_m1 = 1;
        wdata_in_m1 = 32'h8765_4321;
        wstrb_in_m1 = 3;
        wvalid_in_m1 = 1;
        bresp_in_s2 = 3;
        bvalid_in_s2 = 1;
        araddr_in_m1 = 32'h0000_3fff;
        arprot_in_m1 = 2;
        arvalid_in_m1 = 1;
        rdata_in_s2 = 32'hfedc_ba09;
        rvalid_in_s2 = 1;
        rresp_in_s2 = 3;
        // M2 ---> S1
        #30
        awaddr_in_m2 = 32'h0000_2111;
        awprot_in_m2 = 4;
        awvalid_in_m2 = 1;
        wdata_in_m2 = 32'h8765_4321;
        wstrb_in_m2 = 4;
        wvalid_in_m2 = 1;
        bresp_in_s1 = 2;
        bvalid_in_s1 = 1;
        araddr_in_m2 = 32'h0000_2eee;
        arprot_in_m2 = 4;
        arvalid_in_m2 = 1;
        rdata_in_s2 = 32'hfedc_ba09;
        rvalid_in_s2 = 1;
        rresp_in_s2 = 2;
        // M2 ---> S2
        #30
        awaddr_in_m2 = 32'h0000_3111;
        awprot_in_m2 = 5;
        awvalid_in_m2 = 1;
        wdata_in_m2 = 32'h1234_5678;
        wstrb_in_m2 = 5;
        wvalid_in_m2 = 1;
        bresp_in_s2 = 3;
        bvalid_in_s2 = 1;
        araddr_in_m2 = 32'h0000_3eee;
        arprot_in_m2 = 5;
        arvalid_in_m2 = 1;
        rdata_in_s2 = 32'h90ab_cdef;
        rvalid_in_s2 = 1;
        rresp_in_s2 = 3;
        // M1 ---> S1 & M2 ---> S2
        #30
        awaddr_in_m1 = 32'h0000_2222;
        awprot_in_m1 = 6;
        awvalid_in_m1 = 1;
        wdata_in_m1 = 32'h1234_cdef;
        wstrb_in_m1 = 6;
        wvalid_in_m1 = 1;
        bresp_in_s1 = 2;
        bvalid_in_s1 = 1;
        araddr_in_m1 = 32'h0000_2ddd;
        arprot_in_m1 = 6;
        arvalid_in_m1 = 1;
        rdata_in_s1 = 32'h90ab_5678;
        rvalid_in_s1 = 1;
        rresp_in_s1 = 2;
        awaddr_in_m2 = 32'h0000_3222;
        awprot_in_m2 = 7;
        awvalid_in_m2 = 1;
        wdata_in_m2 = 32'h90ab_5678;
        wstrb_in_m2 = 7;
        wvalid_in_m2 = 1;
        bresp_in_s2 = 3;
        bvalid_in_s2 = 1;
        araddr_in_m2 = 32'h0000_3ddd;
        arprot_in_m2 = 7;
        arvalid_in_m2 = 1;
        rdata_in_s2 = 32'h1234_cdef;
        rvalid_in_s2 = 1;
        rresp_in_s2 = 3;
        // M1 ---> S2 & M2 ---> S1
        #30
        awaddr_in_m1 = 32'h0000_3333;
        awprot_in_m1 = 9;
        awvalid_in_m1 = 1;
        wdata_in_m1 = 32'h1234_5678;
        wstrb_in_m1 = 9;
        wvalid_in_m1 = 1;
        bresp_in_s2 = 3;
        bvalid_in_s2 = 1;
        araddr_in_m1 = 32'h0000_3ccc;
        arprot_in_m1 = 9;
        arvalid_in_m1 = 1;
        rdata_in_s2 = 32'h09ab_cdef;
        rvalid_in_s2 = 1;
        rresp_in_s2 = 3;
        awaddr_in_m2 = 32'h0000_2333;
        awprot_in_m2 = 8;
        awvalid_in_m2 = 1;
        wdata_in_m2 = 32'h8765_4321;
        wstrb_in_m2 = 8;
        wvalid_in_m2 = 1;
        bresp_in_s1 = 2;
        bvalid_in_s1 = 1;
        araddr_in_m2 = 32'h0000_2ccc;
        arprot_in_m2 = 8;
        arvalid_in_m2 = 1;
        rdata_in_s2 = 32'hfedc_ba09;
        rvalid_in_s2 = 1;
        rresp_in_s2 = 2;
        // M1 & M2 ---> S1
        #30
        awaddr_in_m1 = 32'h0000_2444;
        awprot_in_m1 = 10;
        awvalid_in_m1 = 1;
        wdata_in_m1 = 32'h90ab_cdef;
        wstrb_in_m1 = 10;
        wvalid_in_m1 = 1;
        bresp_in_s1 = 2;
        bvalid_in_s1 = 1;
        araddr_in_m1 = 32'h0000_2bbb;
        arprot_in_m1 = 10;
        arvalid_in_m1 = 1;
        rdata_in_s1 = 32'h1234_5678;
        rvalid_in_s1 = 1;
        rresp_in_s1 = 2;
        awaddr_in_m2 = 32'h0000_2555;
        awprot_in_m2 = 11;
        awvalid_in_m2 = 1;
        wdata_in_m2 = 32'hfedc_ba09;
        wstrb_in_m2 = 11;
        wvalid_in_m2 = 1;
        bresp_in_s1 = 2;
        bvalid_in_s1 = 1;
        araddr_in_m2 = 32'h0000_2aaa;
        arprot_in_m2 = 11;
        arvalid_in_m2 = 1;
        rdata_in_s2 = 32'h8765_4321;
        rvalid_in_s2 = 1;
        rresp_in_s2 = 2;
        // M1 & M2 ---> S2
        #30
        awaddr_in_m1 = 32'h0000_3666;
        awprot_in_m1 = 12;
        awvalid_in_m1 = 1;
        wdata_in_m1 = 32'h8765_4321;
        wstrb_in_m1 = 12;
        wvalid_in_m1 = 1;
        bresp_in_s2 = 3;
        bvalid_in_s2 = 1;
        araddr_in_m1 = 32'h0000_3999;
        arprot_in_m1 = 12;
        arvalid_in_m1 = 1;
        rdata_in_s2 = 32'hfedc_ba09;
        rvalid_in_s2 = 1;
        rresp_in_s2 = 3;
        awaddr_in_m2 = 32'h0000_3777;
        awprot_in_m2 = 13;
        awvalid_in_m2 = 1;
        wdata_in_m2 = 32'h1234_5678;
        wstrb_in_m2 = 13;
        wvalid_in_m2 = 1;
        bresp_in_s2 = 3;
        bvalid_in_s2 = 1;
        araddr_in_m2 = 32'h0000_3888;
        arprot_in_m2 = 13;
        arvalid_in_m2 = 1;
        rdata_in_s2 = 32'h90ab_cdef;
        rvalid_in_s2 = 1;
        rresp_in_s2 = 3;
        // Invalid Address(s)
        #30
        #30
        awaddr_in_m1 = 32'h0000_1234;
        awprot_in_m1 = 8;
        awvalid_in_m1 = 1;
        wdata_in_m1 = 32'h1234_cdef;
        wstrb_in_m1 = 15;
        wvalid_in_m1 = 1;
        bresp_in_s1 = 1;
        bvalid_in_s1 = 1;
        araddr_in_m1 = 32'h0000_4bcd;
        arprot_in_m1 = 8;
        arvalid_in_m1 = 1;
        rdata_in_s1 = 32'h90ab_5678;
        rvalid_in_s1 = 1;
        rresp_in_s1 = 1;
        awaddr_in_m2 = 32'h0980_3222;
        awprot_in_m2 = 8;
        awvalid_in_m2 = 1;
        wdata_in_m2 = 32'h90ab_5678;
        wstrb_in_m2 = 15;
        wvalid_in_m2 = 1;
        bresp_in_s2 = 1;
        bvalid_in_s2 = 1;
        araddr_in_m2 = 32'h0001_3ddd;
        arprot_in_m2 = 8;
        arvalid_in_m2 = 1;
        rdata_in_s2 = 32'h1234_cdef;
        rvalid_in_s2 = 1;
        rresp_in_s2 = 1;
        #1000 $finish;
    end

endmodule