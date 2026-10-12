module universal_shift_register (
    input clk,
    input reset, // active low
    input [1:0] mode, // 00 = hold, 01 = shift right, 10 = shift left, 11 = parallel load
    input data_shift_right, // input for shift right, enters MSB
    input data_shift_left, // input for shift left, enters LSB
    input [3:0] parallel_in,
    output reg [3:0] q
);

    always @(posedge clk, negedge reset) begin
        if (!reset)
            q <= 4'b0000; // reset
        else begin
            case (mode)
                2'b00: q <= q; // hold
                2'b01: q <= {data_shift_right, q[3:1]}; // shift right
                2'b10: q <= {q[2:0], data_shift_left}; // shift left
                2'b11: q <= parallel_in; // parallel load
            endcase
        end
    end

endmodule