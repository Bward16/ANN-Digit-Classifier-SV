`timescale 1ns / 1ps
module simple_tests(

    );

    parameter IN_WIDTH = 784;

    logic clk;
    logic [127:0] ins[IN_WIDTH];
    logic [127:0] outs[10];
    logic [31:0] addr = 0;

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
