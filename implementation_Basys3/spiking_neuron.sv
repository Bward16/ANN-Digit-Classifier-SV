module spiking_neuron#(
    parameter INPUT_COUNT = 4
    parameter weights = {0,0,0,0}
    // does bias exist in spiking neurons?
    // parameter BIAS = 0
)
(
    input x[INPUT_COUNT],
    output logic result
);

    logic sum;

    always_comb begin

    if(x[0]) begin
        sum += weights[0];
    end
    if(x[1]) begin
        sum += weights[1];
    end
    if(x[2]) begin
        sum += weights[2];
    end
    if(x[3]) begin
        sum += weights[3];
    end


    // to do: activation function
    

    end


    



