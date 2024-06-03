`timescale 1ns / 1ps




module max_index #(parameter N = 10)(input [7:0] array [N-1:0], output reg [3:0] classified);

endmodule




module simple_tests(

    );

    parameter IN_WIDTH = 784;
    parameter NUM_CLASSES = 10;
    
    logic clk;
    logic [63:0] ins[IN_WIDTH];
    logic [63:0] outs[10];
    logic [31:0] addr = 0;
    int classified;
    int correct_count = 0;
    
    int tp[NUM_CLASSES];
    int fp[NUM_CLASSES];
    int tn[NUM_CLASSES];
    int fn[NUM_CLASSES];

    Memory_Reader#(IN_WIDTH) memy_ready(
    clk,
    1,        
    addr,
    ins  // Instruction
    );

    neural_net nnet(
        ins,
        outs
    );
 


    always_comb begin
        int i;
        int max_index = 0;
        classified = -1;
        for (i = 0; i < 10; i = i + 1) begin
            if(outs[i] > outs[max_index]) begin
                max_index = i;
            end
        end
        classified = max_index;
    end

    initial begin
        clk <= 0;
        
        forever #1 clk <= ~clk;
    end

    int labels [0:99] = '{5, 0, 4, 1, 9, 2, 1, 3, 1, 4, 3, 5, 3, 6, 1, 7, 2, 8, 6, 9, 4, 0, 9, 1, 1, 2, 4, 3, 2, 7, 3, 8, 6, 9, 0, 5, 6, 0, 7, 6, 1, 8, 7, 9, 3, 9, 8, 5, 9, 3, 3, 0, 7, 4, 9, 8, 0, 9, 4, 1, 4, 4, 6, 0, 4, 5, 6, 1, 0, 0, 1, 7, 1, 6, 3, 0, 2, 1, 1, 7, 9, 0, 2, 6, 7, 8, 3, 9, 0, 4, 6, 7, 4, 6, 8, 0, 7, 8, 3, 1};
    
    initial begin
    
        // Initialize counters
        for (int k = 0; k < NUM_CLASSES; k = k + 1) begin
            tp[k] = 0;
            fp[k] = 0;
            tn[k] = 0;
            fn[k] = 0;
        end
            
        for (int i = 0; i<100; i = i+1) begin
            addr = i * IN_WIDTH;
            #50;

            if(classified == labels[i]) begin
                correct_count = correct_count + 1;
            end
            
            for (int k = 0; k < NUM_CLASSES; k = k + 1) begin
                if (labels[i] == k) begin
                    if (classified == k) begin
                        tp[k] = tp[k] + 1;
                    end else begin
                        fn[k] = fn[k] + 1;
                    end
                end else begin
                    if (classified == k) begin
                        fp[k] = fp[k] + 1;
                    end else begin
                        tn[k] = tn[k] + 1;
                    end
                end
            end
        end

        $display("Correct classifications: %0d out of 100", correct_count);
        // Print results
        for (int k = 0; k < NUM_CLASSES; k = k + 1) begin
            $display("Class %0d:", k);
            $display("  True Positives: %0d", tp[k]);
            $display("  False Positives: %0d", fp[k]);
            $display("  True Negatives: %0d", tn[k]);
            $display("  False Negatives: %0d", fn[k]);
        end
        $finish;

    end    
        
    

endmodule


