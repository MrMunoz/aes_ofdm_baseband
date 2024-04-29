`timescale 1ns/1ps

module simpl_tb ();

    logic [3:0] x,y, prod;

    spem dut (
        .H(x),
        .B(y),
        .prod(prod)
    );

    initial begin
        $display("Starting Sim"); //print nice message at start
        x = 0;
        y = 0;
        #10;
        for (int i = 0; i < $pow(2, 4); i++) begin
            for (int j = 0; j < $pow(2, 4); j++) begin
                x = i;
                y = j;
                #10;
                $display("H: %h, B: %h, prod: %h", x, y, prod); //print values C-style formatting
                x = j;
                y = i;
                #10;
                $display("H: %h, B: %h, prod: %h", x, y, prod); //print values C-style formatting
           end
        end
        $display("Finishing Sim"); //print nice message at end
        $finish;
    end

endmodule: simpl_tb