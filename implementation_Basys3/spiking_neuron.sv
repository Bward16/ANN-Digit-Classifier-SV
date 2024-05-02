module spiking_neuron#(
    parameter INPUT_COUNT = 4
    parameter weights = {0,0,0,0}
    parameter sum_width = 4
    parameter pos_threshold = 1
    parameter neg_threshold = -1
)
(
    input positive_spike[INPUT_COUNT],
    input negative_spike[INPUT_COUNT],
    output logic pos_spike_out,
    output logic neg_spike out
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
    if(sum > pos_threshold) begin
        sum -= pos_threshold;
        pos_spike_out <= 1;
    end
    else begin
        pos_spike_out <= 0;
    end

    if(sum < neg_threshold) begin
        sum -= neg_threshold;
        neg_spike_out <= 1;
    end
    else begin
        neg_spike_out <= 0;
    end
    

    end


    



