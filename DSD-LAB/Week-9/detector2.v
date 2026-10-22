`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2026 22:35:43
// Design Name: 
// Module Name: detector2
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


module detector2(
        input x,
        input CLK100MHZ,
        output z
    );
    reg [2:0] S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3,
               S4 = 3'd4, S5 = 3'd5, S6 = 3'd6;

    reg [2:0] state = 3'd0;
    reg [2:0] next;

    // next-state logic
    always @(*) begin
        case (state)
            S0: next = x ? S1 : S2;
            S1: next = x ? S1 : S3;
            S2: next = x ? S4 : S2;
            S3: next = x ? S5 : S2;
            S4: next = x ? S1 : S6;
            S5: next = x ? S1 : S6;
            S6: next = x ? S5 : S2;
            default: next = S0;
        endcase
    end

    // 1 Hz tick counter
    reg [31:0] count = 0;
    always @ (posedge CLK100MHZ) begin
        if (count == 99999999) begin
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end

    // state register, advances once per second
    always @ (posedge CLK100MHZ) begin
        if (count == 99999999) begin
            state <= next;
        end
    end

    // Moore output: depends on state only
    assign z = (state == S5) || (state == S6);
endmodule