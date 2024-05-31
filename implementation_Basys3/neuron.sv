`timescale 1ns / 1ps
module Simple_Neuron#( 
    parameter INPUT_COUNT = 4, 
    parameter int weights [INPUT_COUNT] = {0, 0, 0, 0},
    parameter BIAS = 0
    ) 
    (
    input [7:0] x[INPUT_COUNT],
    output logic [31:0] result
);

    logic [7:0] sum;

    always_comb begin

        sum = BIAS;
        
        for (int i = 0; i < INPUT_COUNT; i++) begin
            sum += x[i] * weights[i];
        end

        result = ($signed(sum) > 0) ? sum : 0;

    end


endmodule