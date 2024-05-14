`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2024 05:27:49 PM
// Design Name: 
// Module Name: neuron_layer
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


module neuron_layer#( 
    parameter LAYER_NUM,
    parameter PREV_WIDTH = 4,
    parameter WIDTH = 4,
    parameter int WEIGHTS[WIDTH][PREV_WIDTH],
    parameter int BIASES[WIDTH]
    )(
        input [31:0] dendrons [PREV_WIDTH],
        output[31:0] axons    [WIDTH]

    );


    genvar neuron;
    generate
        for (neuron = 0; neuron < WIDTH; neuron = neuron + 1) begin

            Simple_Neuron #(
                PREV_WIDTH, 
                WEIGHTS[neuron], 
                BIASES[neuron]) s_neur(

                dendrons,
                axons[neuron]

            );

        end
    endgenerate
endmodule
