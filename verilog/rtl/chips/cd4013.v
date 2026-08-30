module cd4013 (
    input wire d1, d2,          // data input
    input wire clk1, clk2,      // clock input
    input wire set1, set2,      // set input
    input wire rst1, rst2,      // reset input
    output reg q1, q2,          // Q output
    output wire qn1, qn2        // ¬Q output
);

    // Flip-flop 1
    always @(posedge clk1 or posedge set1 or posedge rst1) begin
        if (set1)
            q1 <= 1'b1;
        else if (rst1)
            q1 <= 1'b0;
        else
            q1 <= d1;
    end
    assign qn1 = ~q1;

    // Flip-flop 2
    always @(posedge clk2 or posedge set2 or posedge rst2) begin
        if (set2)
            q2 <= 1'b1;
        else if (rst2)
            q2 <= 1'b0;
        else
            q2 <= d2;
    end
    assign qn2 = ~q2;

endmodule
