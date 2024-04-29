`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 02:39:41 PM
// Design Name: 
// Module Name: neuron
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Simple_Neuron#( 
    parameter INPUT_COUNT = 4, 
    parameter[31:0] weights [INPUT_COUNT],
    parameter BIAS,
    parameter SIGMOID
    ) 
    (
    input [31:0] x[N],
    input [31:0] bias,
    output [31:0] result
);

    logic [31:0] sum;

    always_comb begin

        sum = BIAS;
        
        for (int i = 0; i < N; i++) begin
            sum += x[i] * weights[i];
        end

        result = (sum > SIGMOID) ? 1 : 0;

    end


endmodule
