module spiking_neuron #(
    parameter INPUT_COUNT = 4,
    parameter integer weights[INPUT_COUNT] = '{1, 1, 1, 1}, // Default weights of 1 for each input
    parameter sum_width = 4,
    parameter pos_threshold = 1,
    parameter neg_threshold = -1
)
(
    input logic clk,
    input logic reset,
    input logic [INPUT_COUNT-1:0] positive_spike,
    input logic [INPUT_COUNT-1:0] negative_spike,
    output logic pos_spike_out,
    output logic neg_spike_out
);

    logic signed [sum_width-1:0] sum;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            sum <= 0;
            pos_spike_out <= 0;
            neg_spike_out <= 0;
        end else begin
            for (int i = 0; i < INPUT_COUNT; i++) begin
                if (positive_spike[i]) begin
                    sum += weights[i];
                end
                if (negative_spike[i]) begin
                    sum -= weights[i];
                end
            end

            // Activation checks
            if (sum > pos_threshold) begin
                sum -= pos_threshold; // Reduce sum by threshold to simulate spike generation
                pos_spike_out <= 1;
            end else begin
                pos_spike_out <= 0;
            end

            if (sum < neg_threshold) begin
                sum -= neg_threshold; // Reduce sum by threshold to simulate spike generation
                neg_spike_out <= 1;
            end else begin
                neg_spike_out <= 0;
            end
        end
    end
endmodule
