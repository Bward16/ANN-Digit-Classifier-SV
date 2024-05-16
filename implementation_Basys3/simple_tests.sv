`timescale 1ns / 1ps
module simple_tests(

    );

    logic clk;
    logic [31:0] ins[7];
    logic [31:0] outs[1];
    
    neural_net nnet(
        ins,
        outs
    );
 


    initial begin
        clk <= 0;
        
        forever #1 clk <= ~clk;
    end
    initial begin
            ins = {0,0,0,0,0,0,0};

            #2 
            ins = {1,2,3,4,5,6,7};

            #50
            ins = {0,0,0,0,0,0,0};;

    end

endmodule
