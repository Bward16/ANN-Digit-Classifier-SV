`timescale 1ns / 1ps
module simple_tests();
    logic clk;
    logic reset;
    logic [3:0] pos_ins;  // Array should be declared like this for bit indexing
    logic [3:0] neg_ins;
    logic pos_out;
    logic neg_out;    

    spiking_neuron #(
        .INPUT_COUNT(4),
        .weights('{1,2,3,4}), // Correct syntax for array assignments
        .sum_width(6),
        .pos_threshold(10),
        .neg_threshold(-10)
    ) neuro1 (
        .clk(clk),
        .reset(reset),
        .positive_spike(pos_ins),
        .negative_spike(neg_ins),
        .pos_spike_out(pos_out),
        .neg_spike_out(neg_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    // Initial reset and stimulus application
    initial begin
        reset = 1;
        pos_ins = 4'b0000;
        neg_ins = 4'b0000;
        #5 reset = 0;  // Deassert reset after 5 time units

        // Apply a test vector after some delay
        #2;
        pos_ins = 4'b1111;  // Activating all positive inputs
        neg_ins = 4'b0000;  // No negative input spikes

        #2;
        pos_ins = 4'b0000;  // Deactivating all positive inputs
        neg_ins = 4'b0000;  // No negative input spikes
        
        #2;
        pos_ins = 4'b0000;  // No positive input spikes
        neg_ins = 4'b1111;  // Activating all negative inputs

        #2;
        pos_ins = 4'b0000;  // No positive input spikes
        neg_ins = 4'b0000;  // Deactivating all negative inputs
        
        // Allow some time to observe outputs
        #10;

        $finish;  // End the simulation
    end

endmodule
