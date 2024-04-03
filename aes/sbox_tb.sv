`timescale 1ns / 1ps
`default_nettype none
module sbox_tb #(parameter int EXP_WIDTH = 5)();
    logic [7:0] x;
    logic [7:0] temp;
    logic [7:0] y;   

    isomorphic_map dut1(x, temp);

    affine_inverse_iso dut2(temp, y);


    //initial block...this is our test simulation
    initial begin
        $display("Starting Sim"); //print nice message at start
        x = 'h0f;
        #10
   
        $display("output: %b", y); //print values C-style formatting
        $display("Finishing Sim"); //print nice message at end
        $finish;
    end
endmodule: sbox_tb