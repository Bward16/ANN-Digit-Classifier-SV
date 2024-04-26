
module #( parameter N = 4) (
    input logic [31:0] x[N],
    input logic [31:0] w[N],
    input logic [31:0] bias,
    input logic [31:0] sigmoid,
    output logic [31:0] y
);

    logic [31:0] sum;

    always_comb begin

        sum = bias;
        
        for (int i = 0; i < N; i++) begin
            sum += x[i] * w[i];
        end

        y = (sum > sigmoid) ? 1 : 0;

    end

endmodule