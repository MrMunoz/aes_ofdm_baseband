`timescale 1ns/1ps

module sub_bytes_tb ();
    logic clock;

    always begin
        #2.5;
        clock = 0;
        #2.5;
        clock = 1;
    end
    
    int count, file;
    string file_path = "testvectors/sub_bytes.txt";
    logic [127:0] x,y;

    sub_bytes dut (
        .clk(clock),
        .data_in(x),
        .data_out(y)
    );

    initial begin
        $dumpfile("sub_bytes.test.vcd");
        $dumpvars(0, sub_bytes_tb);
        $display("----- sub_bytes Unit Test -----");
        file = $fopen(file_path, "r");
        count = 0;
    end

    always_ff @(posedge clock) begin
        // x <= x + 1;
        $fscanf(file, "%h", x);
        count <= count + 1;
       // $display("in: %h", x);
    end 

    always_ff @(posedge clock) begin
        $display("%h", y);
        if (count == 20) begin
            $finish;
        end
    end



endmodule: sub_bytes_tb