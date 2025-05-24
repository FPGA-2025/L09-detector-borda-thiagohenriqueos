module detector_borda (
    input clk,
    input rst,
    input [1:0] entrada,
    output reg [1:0] detector
);

    reg [1:0] entrada_antiga; // Guarda o valor anterior da entrada para comparação

    always @(posedge clk or rst) begin
        if (rst) begin
            entrada_antiga <= 2'b00;
            detector <= 2'b00;
        end else begin
            // Detecta borda de subida: antes era 0 e agora é 1
            detector <= (~entrada_antiga) & entrada;

            // Atualiza o valor antigo com o valor atual
            entrada_antiga <= entrada;
        end
    end

endmodule
