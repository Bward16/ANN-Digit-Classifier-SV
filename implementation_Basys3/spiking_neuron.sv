module spiking_neuron#(
    parameter INPUT_COUNT = 4
    parameter weights = {0,0,0,0}
    parameter sum_width = 4
    // does bias exist in spiking neurons?
    // parameter BIAS = 0
)
(
    input positive_spike[INPUT_COUNT],
    input negative_spike[INPUT_COUNT],
    output logic spike
);

    logic signed [sum_width-1:0] sum;

    always_ff begin

        // make adding to sum based on n bit input
        for(int i = 0; i < INPUT_COUNT; i++) begin
            if(positive_spike[i]) begin
                sum += weights[i];
            end
            if(negative_spike[i]) begin
                sum -= weights[i];
            end
        end


    // to do: activation function
    

    end


    



