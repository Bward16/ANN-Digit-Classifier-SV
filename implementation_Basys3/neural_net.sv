

module neural_net#( 

    ) (
    input [31:0] inputs[LAYER_WIDTHS[0]],
    output [31:0] outputs[LAYER_WIDTHS[LAYERS-1]]

);
`include "parameters.vh"

    genvar layer;
    generate

        
        for (layer = 0; layer < LAYERS; layer = layer + 1) begin : module_inst

            wire [31:0] dendrons[LAYER_WIDTHS[layer]];
            wire [31:0] axons[LAYER_WIDTHS[layer+1]];

            if(layer == 0) assign dendrons = inputs;
            else assign dendrons = module_inst[layer-1].s_lay.axons;

            neuron_layer #(
                layer,
                LAYER_WIDTHS[layer], 
                LAYER_WIDTHS[layer+1], 
                WEIGHTS[layer][0:+LAYER_WIDTHS[layer+1]-1], 
                BIASES[layer][0:+LAYER_WIDTHS[layer+1]-1]) s_lay(

                dendrons,
                axons

            );

            if(layer == LAYERS - 1) assign outputs = axons;

        end
    endgenerate


endmodule