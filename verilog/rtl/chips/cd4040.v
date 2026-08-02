module cd4040 (
    input wire clock,    // Clock
    input wire reset,    // Reset
    output reg [11:0] q  // 12 channels
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            q <= 12'b000000000000; // Reset
        end else begin
            q <= q + 1;
        end
    end

endmodule
