module axi4_lite_crossbar (
    input aclk,
    input aresetn,
    // Write Address Channel
    // Master 1
    input [31:0] awaddr_in_m1,
    input [2:0] awprot_in_m1,
    input awvalid_in_m1,
    // Master 2
    input [31:0] awaddr_in_m2,
    input [2:0] awprot_in_m2,
    input awvalid_in_m2,
    // Slave 1
    output reg [31:0] awaddr_out_s1,
    output reg [2:0] awprot_out_s1,
    output reg awvalid_out_s1,
    // Slave 2
    output reg [31:0] awaddr_out_s2,
    output reg [2:0] awprot_out_s2,
    output reg awvalid_out_s2,
    // Write Data Channel
    // Master 1
    input [31:0] wdata_in_m1,
    input [3:0] wstrb_in_m1,
    input wvalid_in_m1,
    // Master 2
    input [31:0] wdata_in_m2,
    input [3:0] wstrb_in_m2,
    input wvalid_in_m2,
    // Slave 1
    output reg [31:0] wdata_out_s1,
    output reg [3:0] wstrb_out_s1,
    output reg wvalid_out_s1,
    // Slave 2
    output reg [31:0] wdata_out_s2,
    output reg [3:0] wstrb_out_s2,
    output reg wvalid_out_s2,
    // Write Response Channel
    // Master 1
    output reg [1:0] bresp_out_m1,
    output reg bvalid_out_m1,
    // Master 2
    output reg [1:0] bresp_out_m2,
    output reg bvalid_out_m2,
    // Slave 1
    input [1:0] bresp_in_s1,
    input bvalid_in_s1,
    // Slave 2
    input [1:0] bresp_in_s2,
    input bvalid_in_s2,
    // Read Address Channel
    // Master 1
    input [31:0] araddr_in_m1,
    input [2:0] arprot_in_m1,
    input arvalid_in_m1,
    // Master 2
    input [31:0] araddr_in_m2,
    input [2:0] arprot_in_m2,
    input arvalid_in_m2,
    // Slave 1
    output reg [31:0] araddr_out_s1,
    output reg [2:0] arprot_out_s1,
    output reg arvalid_out_s1,
    // Slave 2
    output reg [31:0] araddr_out_s2,
    output reg [2:0] arprot_out_s2,
    output reg arvalid_out_s2,
    // Read Data Channel
    // Master 1
    output reg [31:0] rdata_out_m1,
    output reg rvalid_out_m1,
    output reg [1:0] rresp_out_m1,
    // Master 2
    output reg [31:0] rdata_out_m2,
    output reg rvalid_out_m2,
    output reg [1:0] rresp_out_m2,
    // Slave 1
    input [31:0] rdata_in_s1,
    input rvalid_in_s1,
    input [1:0] rresp_in_s1,
    // Slave 2
    input [31:0] rdata_in_s2,
    input rvalid_in_s2,
    input [1:0] rresp_in_s2
);
    
    reg count_2;

    always @(posedge aclk) begin
        if (!aresetn) begin
            count_2 <= 0;
        end
        else begin
            count_2 <= count_2 + 1;
        end
    end

    always @(*) begin
        case (count_2)
            0: begin
                if (awaddr_in_m1 >= 32'h0000_2000 && awaddr_in_m1 <= 32'h0000_2fff) begin
                    awaddr_out_s1 = awaddr_in_m1;
                    awprot_out_s1 = awprot_in_m1;
                    awvalid_out_s1 = awvalid_in_m1;
                    wdata_out_s1 = wdata_in_m1;
                    wstrb_out_s1 = wstrb_in_m1;
                    wvalid_out_s1 = wvalid_in_m1;
                    bresp_out_m1 = bresp_in_s1;
                    bvalid_out_m1 = bvalid_in_s1;
                end
                else if (/*awaddr_in_m1 >= 32'h0000_3000 && awaddr_in_m1 <= 32'h0000_3fff*/awaddr_in_m2 >= 32'h0000_2000 && awaddr_in_m2 <= 32'h0000_2fff) begin
                    // awaddr_out_s2 = awaddr_in_m1;
                    // awprot_out_s2 = awprot_in_m1;
                    // awvalid_out_s2 = awvalid_in_m1;
                    // wdata_out_s2 = wdata_in_m1;
                    // wstrb_out_s2 = wstrb_in_m1;
                    // wvalid_out_s2 = wvalid_in_m1;
                    // bresp_out_m1 = bresp_in_s2;
                    // bvalid_out_m1 = bvalid_in_s2;
                    //
                    awaddr_out_s1 = awaddr_in_m2;
                    awprot_out_s1 = awprot_in_m2;
                    awvalid_out_s1 = awvalid_in_m2;
                    wdata_out_s1 = wdata_in_m2;
                    wstrb_out_s1 = wstrb_in_m2;
                    wvalid_out_s1 = wvalid_in_m2;
                    bresp_out_m2 = bresp_in_s1;
                    bvalid_out_m2 = bvalid_in_s1;
                end
                if (/*awaddr_in_m2 >= 32'h0000_2000 && awaddr_in_m2 <= 32'h0000_2fff*/awaddr_in_m1 >= 32'h0000_3000 && awaddr_in_m1 <= 32'h0000_3fff) begin
                    // awaddr_out_s1 = awaddr_in_m2;
                    // awprot_out_s1 = awprot_in_m2;
                    // awvalid_out_s1 = awvalid_in_m2;
                    // wdata_out_s1 = wdata_in_m2;
                    // wstrb_out_s1 = wstrb_in_m2;
                    // wvalid_out_s1 = wvalid_in_m2;
                    // bresp_out_m2 = bresp_in_s1;
                    // bvalid_out_m2 = bvalid_in_s1;
                    //
                    awaddr_out_s2 = awaddr_in_m1;
                    awprot_out_s2 = awprot_in_m1;
                    awvalid_out_s2 = awvalid_in_m1;
                    wdata_out_s2 = wdata_in_m1;
                    wstrb_out_s2 = wstrb_in_m1;
                    wvalid_out_s2 = wvalid_in_m1;
                    bresp_out_m1 = bresp_in_s2;
                    bvalid_out_m1 = bvalid_in_s2;
                end
                else if (awaddr_in_m2 >= 32'h0000_3000 && awaddr_in_m2 <= 32'h0000_3fff) begin
                    awaddr_out_s2 = awaddr_in_m2;
                    awprot_out_s2 = awprot_in_m2;
                    awvalid_out_s2 = awvalid_in_m2;
                    wdata_out_s2 = wdata_in_m2;
                    wstrb_out_s2 = wstrb_in_m2;
                    wvalid_out_s2 = wvalid_in_m2;
                    bresp_out_m2 = bresp_in_s2;
                    bvalid_out_m2 = bvalid_in_s2;
                end
            end
            1: begin
                if (awaddr_in_m1 >= 32'h0000_2000 && awaddr_in_m1 <= 32'h0000_2fff) begin
                    if (awaddr_in_m2 >= 32'h0000_2000 && awaddr_in_m2 <= 32'h0000_2fff) begin
                        awaddr_out_s1 = awaddr_in_m2;
                        awprot_out_s1 = awprot_in_m2;
                        awvalid_out_s1 = awvalid_in_m2;
                        wdata_out_s1 = wdata_in_m2;
                        wstrb_out_s1 = wstrb_in_m2;
                        wvalid_out_s1 = wvalid_in_m2;
                        bresp_out_m2 = bresp_in_s1;
                        bvalid_out_m2 = bvalid_in_s1;
                    end
                end
                else if (awaddr_in_m1 >= 32'h0000_3000 && awaddr_in_m1 <= 32'h0000_3fff) begin
                    if (awaddr_in_m2 >= 32'h0000_3000 && awaddr_in_m2 <= 32'h0000_3fff) begin
                        awaddr_out_s2 = awaddr_in_m2;
                        awprot_out_s2 = awprot_in_m2;
                        awvalid_out_s2 = awvalid_in_m2;
                        wdata_out_s2 = wdata_in_m2;
                        wstrb_out_s2 = wstrb_in_m2;
                        wvalid_out_s2 = wvalid_in_m2;
                        bresp_out_m2 = bresp_in_s2;
                        bvalid_out_m2 = bvalid_in_s2;
                    end
                end
            end
            // default:
        endcase
    end

    always @(*) begin
        case (count_2)
            0: begin
                if (awaddr_in_m1 >= 32'h0000_2000 && awaddr_in_m1 <= 32'h0000_2fff) begin
                    araddr_out_s1 <= araddr_in_m1;
                    arprot_out_s1 <= arprot_in_m1;
                    arvalid_out_s1 <= arvalid_in_m1;
                    rdata_out_m1 <= rdata_in_s1;
                    rvalid_out_m1 <= rvalid_in_s1;
                    rresp_out_m1 <= rresp_in_s1;
                end
                else if (awaddr_in_m2 >= 32'h0000_2000 && awaddr_in_m2 <= 32'h0000_2fff) begin
                    araddr_out_s1 <= araddr_in_m2;
                    arprot_out_s1 <= arprot_in_m2;
                    arvalid_out_s1 <= arvalid_in_m2;
                    rdata_out_m2 <= rdata_in_s1;
                    rvalid_out_m2 <= rvalid_in_s1;
                    rresp_out_m2 <= rresp_in_s1;
                end
                if (awaddr_in_m1 >= 32'h0000_3000 && awaddr_in_m1 <= 32'h0000_3fff) begin
                    araddr_out_s2 <= araddr_in_m1;
                    arprot_out_s2 <= arprot_in_m1;
                    arvalid_out_s2 <= arvalid_in_m1;
                    rdata_out_m1 <= rdata_in_s2;
                    rvalid_out_m1 <= rvalid_in_s2;
                    rresp_out_m1 <= rresp_in_s2; 
                end
                else if (awaddr_in_m2 >= 32'h0000_3000 && awaddr_in_m2 <= 32'h0000_3fff) begin
                    araddr_out_s2 <= araddr_in_m2;
                    arprot_out_s2 <= arprot_in_m2;
                    arvalid_out_s2 <= arvalid_in_m2;
                    rdata_out_m2 <= rdata_in_s2;
                    rvalid_out_m2 <= rvalid_in_s2;
                    rresp_out_m2 <= rresp_in_s2;
                end
            end
            1: begin
                if (awaddr_in_m1 >= 32'h0000_2000 && awaddr_in_m1 <= 32'h0000_2fff) begin
                    if (awaddr_in_m2 >= 32'h0000_2000 && awaddr_in_m2 <= 32'h0000_2fff) begin
                        araddr_out_s1 <= araddr_in_m2;
                        arprot_out_s1 <= arprot_in_m2;
                        arvalid_out_s1 <= arvalid_in_m2;
                        rdata_out_m2 <= rdata_in_s1;
                        rvalid_out_m2 <= rvalid_in_s1;
                        rresp_out_m2 <= rresp_in_s1;
                    end
                end
                else if (awaddr_in_m1 >= 32'h0000_3000 && awaddr_in_m1 <= 32'h0000_3fff) begin
                    if (awaddr_in_m2 >= 32'h0000_3000 && awaddr_in_m2 <= 32'h0000_3fff) begin
                        araddr_out_s2 <= araddr_in_m2;
                        arprot_out_s2 <= arprot_in_m2;
                        arvalid_out_s2 <= arvalid_in_m2;
                        rdata_out_m2 <= rdata_in_s2;
                        rvalid_out_m2 <= rvalid_in_s2;
                        rresp_out_m2 <= rresp_in_s2;
                    end
                end
            end
            // default:
        endcase
    end

endmodule