`timescale 1ns/1ps

module simpl_tb ();
    
    logic [3:0] x,y;

    simpl dut (
        .x(x),
        .y(y)
    );

    initial begin
        $display("Starting Sim"); //print nice message at start
        x = 0;
        #10
        for (int i = 0; i < $pow(2, 4); i++) begin
                x = i;
                #10;
                $display("in: %h, out: %h", x, y); //print values C-style formatting
        end
        $display("Finishing Sim"); //print nice message at end
        $finish;
    end

endmodule: simpl_tb