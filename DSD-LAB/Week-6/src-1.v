module d_flip_flop (
    input clk,
    input reset, // active low
    input preset,
    input d,
    output reg q
);

    always @(posedge clk, negedge reset) begin
        if (!reset)
            q <= 1'b0;
        else if (preset)
            q <= 1'b1;
        else
            q <= d;
    end

endmodule