module cd4063 (
    input [3:0] A, B,      // Input
    input a_gt_b_in,       // Cascade Input: A > B
    input a_lt_b_in,       // Cascade Input: A < B
    input a_eq_b_in,       // Cascade Input: A = B
    output a_gt_b_out,     // Output: A > B
    output a_lt_b_out,     // Output: A < B
    output a_eq_b_out      // Output: A = B
);

    wire eq, gt, lt;

    assign gt = (A > B);
    assign lt = (A < B);
    assign eq = (A == B);

    assign a_gt_b_out = gt | (eq & a_gt_b_in);
    assign a_lt_b_out = lt | (eq & a_lt_b_in);
    assign a_eq_b_out = eq & a_eq_b_in;

endmodule
