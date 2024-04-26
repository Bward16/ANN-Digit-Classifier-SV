
module (
    input logic [:0] a,
    input logic [31:0] b,
    input logic [31:0] c,
    input logic [31:0] d,

    input logic [31:0] w0,
    input logic [31:0] w1,
    input logic [31:0] w2,
    input logic [31:0] w3,

    input logic [31:0] sigmoid,

    output logic [31:0] y
);

    logic [31:0] sum;

    always_comb begin 

        sum = a * w0 + b * w1 + c * w2 + d * w3;

        y = (sum > sigmoid) ? 1 : 0;

    end

endmodule