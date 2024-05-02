`timescale 1ns / 1ps
module simple_tests_spiking(

    );

    logic [31:0] out;
    logic clk;
    logic [31:0] ins[4];
    
    Simple_Neuron#( 
        4, 
        {1,2,3,4},
        2
    ) neuro1
        (
        ins,
        out
    );
 


    initial begin
        clk <= 0;
        
        forever #1 clk <= ~clk;
    end
    initial begin
            ins = {0,0,0,0};

            #2 
            ins = {1,-2,-3,-4};

            #50
            ins = {0,0,0,0};

    end

endmodule
