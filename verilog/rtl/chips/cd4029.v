module cd4029 (
    input wire clk,              // Clock input
    input wire reset,            // Reset
    input wire preset_enable,    // Preset Enable
    input wire up_down,          // HIGH = UP, LOW = DOWN
    input wire binary_decade,    // HIGH = BINARY, LOW = DECADE (BCD)
    input wire [3:0] preset_data,// Entradas de dados para preset (J, K, L, M)
    output reg [3:0] q,          // Saídas (QA, QB, QC, QD)
    output wire carry_out        // Carry Out para cascatear CIs
);

    // Controle de Preset (Sincrono) e Contagem
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (preset_enable) begin
            q <= preset_data;
        end else begin
            if (binary_decade) begin
                if (up_down) begin
                    if (q == 4'b1111) q <= 4'b0000;
                    else q <= q + 1;
                end else begin
                    if (q == 4'b0000) q <= 4'b1111;
                    else q <= q - 1;
                end
            end else begin
                if (up_down) begin
                    if (q == 4'b1001) q <= 4'b0000;
                    else q <= q + 1;
                end else begin
                    if (q == 4'b0000) q <= 4'b1001;
                    else q <= q - 1;
                end
            end
        end
    end

    assign carry_out = (binary_decade) ? 
                       ((up_down) ? (q == 4'b1111) : (q == 4'b0000)) : 
                       ((up_down) ? (q == 4'b1001) : (q == 4'b0000));

endmodule
