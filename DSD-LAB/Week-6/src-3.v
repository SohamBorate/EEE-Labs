module shift_register (
    input clk,
    input reset, // active low
    input mode, // 1 = parallel load, 0 = shift
    input shift_mode, // 1 = shift left, 0 = shift right
    input data_in,
    input [3:0] parallel_in,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (!reset)
            q <= 4'b0000; // reset
        else if (mode)
            q <= parallel_in; // parallel load
        else if (shift_mode)
            q <= {q[2:0], data_in}; // shift left, data_in enters LSB
        else
            q <= {data_in, q[3:1]}; // shift right, data_in enters MSB
    end

endmodule