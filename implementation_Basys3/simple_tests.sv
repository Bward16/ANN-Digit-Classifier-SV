`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2024 04:16:21 PM
// Design Name: 
// Module Name: simple_tests
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simple_tests(

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
            ins = {1,2,3,4};

            #50
            ins = {0,0,0,0};

    end

endmodule
