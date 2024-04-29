module neural_net#( 
    parameter LAYERS = 4,
    parameter LAYER_WIDTHS[LAYERS] = {4,4,4,4}
    ) (
    input [31:0] inputs[INPUT_LAYER_WIDTH],
    input [31:0] w[N],
    input [31:0] bias,
    input [31:0] sigmoid,
    output [31:0] y
);
`include "parameters.vh"

    wire [31:0] dendrons [128]; //TODO calculate actual dendron count


    genvar neuron, layer;
    generate 

        //TODO calculate dendrex
        int dendrex = 0;

        for(layer = 1; layer < LAYERS; layer = layer+1)begin

    
            //generate input layer
            for (neuron = 0; neuron < LAYER_WIDTHS[layer]; neuron = neuron + 1) begin

                Simple_Neuron #(LAYER_WIDTHS[layer], weights[layer], biases[layer][neuron], sigmoids[layer][neuron]) s_neur(

                    dendrons[dendrex + LAYER_WIDTHS[layer-1] : dendrex],
                    dendrons[dendrex + LAYER_WIDTHS[layer] + LAYER_WIDTHS[layer-1] : dendrex + LAYER_WIDTHS[layer-1]]

                );

            end

            //dendrex += LAYER_WIDTHS[layer-1];
        end
    endgenerate
endmodule