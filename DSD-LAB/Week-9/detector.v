`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2026 20:44:58
// Design Name: 
// Module Name: detector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module detector(
        input x,
        input CLK100MHZ,
        output z
    );
    reg [1:0] S0 = 2'd0, S1 = 2'd1, S2 = 2'd2, S3 = 2'd3;

    reg [1:0] state = 2'd0;   // initial value works on FPGA; add a reset port if you prefer
    reg [1:0] next;

    // next-state logic
    always @(*) begin
        case (state)
            S0: next = x ? S1 : S0;
            S1: next = x ? S1 : S2;
            S2: next = x ? S3 : S0;
            S3: next = x ? S1 : S2;
            default: next = S0;
        endcase
    end
    reg [31:0] count = 0;
    // state register
    always @ (posedge CLK100MHZ) begin
        if (count == 99999999) begin
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end

    always @ (posedge CLK100MHZ) begin
        if (count == 99999999) begin
            state <= next;
        end
    end

    assign z = (state == S3) && !x;
endmodule
