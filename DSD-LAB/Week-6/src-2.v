module updown_counter (
    input clk,
    input reset, // active low
    input mode, // 1 = up, 0 = down
    output reg [3:0] q
);

    always @(posedge clk, negedge reset) begin
        if (!reset)
            q <= 4'b0000; // reset
        else if (mode)
            q <= q + 1'b1; // increment
        else
            q <= q - 1'b1; // decrement
    end

endmodule