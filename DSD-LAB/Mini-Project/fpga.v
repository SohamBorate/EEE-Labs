module pwm_2khz (
    input clk,
    input [7:0] duty,
    output reg pwm
);
    reg [7:0] count = 8'd0;

    // 512 kHz clock => 1953.125 ns period
    // 2 kHz PWM => 256 clock cycles per period

    always @(posedge clk) begin
        if (count == 8'd255) begin
            count <= 8'd0;
        end else begin
            count <= count + 1;
        end

        // Compare counter with duty value
        // duty = 0H -> 0%
        // duty = 80H -> 50%
        // duty = FFH -> 100%
        if (count < duty) begin
            pwm <= 1'b1;
        end else begin
            pwm <= 1'b0;
        end
    end
endmodule
