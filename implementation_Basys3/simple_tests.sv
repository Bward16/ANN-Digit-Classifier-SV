`timescale 1ns / 1ps




module max_index #(parameter N = 10)(input [7:0] array [N-1:0], output reg [3:0] classified);

endmodule




module simple_tests(

    );

    parameter IN_WIDTH = 784;

    logic clk;
    logic [63:0] ins[IN_WIDTH];
    logic [63:0] outs[10];
    logic [31:0] addr = 0;
    int classified;

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
    initial begin
            
            addr = 0;
            #50 
            addr = addr + IN_WIDTH;

             #50
             addr = addr + IN_WIDTH;

             #50
             addr = addr + IN_WIDTH;

            // #50
            // addr = addr + IN_WIDTH;
            
            $finish;
            

    end

endmodule


