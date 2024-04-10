`timescale 1ns/1ps

module sbox_tb ();
    logic clock;

    always begin
        #2.5;
        clock = 0;
        #2.5;
        clock = 1;
    end
    
    logic [7:0] x,y,my_x;

    sbox dut (
        .clk(clock),
        .x(x),
        .y(y),
        .my_x(my_x)
    );

    initial begin
        $dumpfile("sbox.test.vcd");
        $dumpvars(0, sbox_tb);
        $display("----- sbox Unit Test -----");
        x = 'h00;
    end

    always_ff @(posedge clock) begin
        x <= x + 1;
       // $display("in: %h", x);
    end 

    always_ff @(posedge clock) begin
        $display("out: y: %h my_x: %h", y, my_x);
        if (my_x == 'hFF) begin
            $finish;
        end
    end



endmodule: sbox_tb