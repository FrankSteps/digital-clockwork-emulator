module cd4511 (
    input wire [3:0] bcd_in,      // 4-bit BCD input (D, C, B, A)
    input wire LE,                // Latch Enable (Active High)
    input wire BL,                // Blanking Input (Active Low)
    input wire LT,                // Lamp Test (Active Low)
    output reg [6:0] seg_out      // 7-segment output {g, f, e, d, c, b, a}
);

    reg [3:0] latched_bcd;

    // Latch and Control Logic
    always @* begin
        if (~BL) begin
            seg_out = 7'b0000000; // Blank display
        end else if (~LT) begin
            seg_out = 7'b1111111; // Lamp Test: all segments on
        end else begin
            if (~LE) begin
                latched_bcd = bcd_in;
            end
            
            // BCD to 7-Segment Decoder Truth Table
            case (latched_bcd)
                // g f e d c b a
                4'b0000: seg_out = 7'b1111110; // '0'
                4'b0001: seg_out = 7'b0110000; // '1'
                4'b0010: seg_out = 7'b1101101; // '2'
                4'b0011: seg_out = 7'b1111001; // '3'
                4'b0100: seg_out = 7'b0110011; // '4'
                4'b0101: seg_out = 7'b1011011; // '5'
                4'b0110: seg_out = 7'b1011111; // '6'
                4'b0111: seg_out = 7'b1110000; // '7'
                4'b1000: seg_out = 7'b1111111; // '8'
                4'b1001: seg_out = 7'b1111011; // '9'
                default: seg_out = 7'b0000000; // ___
            endcase
        end
    end
endmodule
