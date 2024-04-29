`timescale 1ns/1ps

module aes_round_tb ();
    logic clock;

    always begin
        #2.5;
        clock = 0;
        #2.5;
        clock = 1;
    end

    int count, file;
    string file_path = "testvectors/aes_round.txt";
    logic [127:0] x, k ,y;

    aes_round dut (
        .clk(clock),
        .rst(rst),
        .data_in(x),
        .round_key(k),
        .data_out(y)
    );

    initial begin
        $dumpfile("aes_round.test.vcd");
        $dumpvars(0, aes_round_tb);
        $display("----- aes_round Unit Test -----");
        file = $fopen(file_path, "r");
        count = 0;
    end

    always_ff @(posedge clock) begin
        // x <= x + 1;
        if(count % 10 == 0) begin
            $fscanf(file, "%h %h", x, k);
        end
        count <= count + 1;
       // $display("in: %h", x);
    end

    always_ff @(posedge clock) begin
        $display("%h", y);
        if (count == 200) begin
            $finish;
        end
    end



endmodule: aes_round_tb