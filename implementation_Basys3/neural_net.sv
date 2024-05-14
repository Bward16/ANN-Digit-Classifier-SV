module neural_net#( 
    parameter LAYERS = 4,
    parameter int LAYER_WIDTHS[4] = {4,4,4,4}
    ) (
    input [31:0] inputs[LAYER_WIDTHS[0]]

);
`include "parameters.vh"

    

    genvar layer;
    generate

        
        for (layer = 0; layer < 1; layer = layer + 1) begin

            wire [31:0] dendrons[LAYER_WIDTHS[layer]];
            wire [31:0] axons[LAYER_WIDTHS[layer+1]];

            if(layer == 0) assign dendrons = inputs;

            neuron_layer #(
                layer,
                LAYER_WIDTHS[layer], 
                LAYER_WIDTHS[layer+1], 
                WEIGHTS, 
                BIASES[layer]) s_lay(

                dendrons,
                axons

            );


        end
    endgenerate

endmodule