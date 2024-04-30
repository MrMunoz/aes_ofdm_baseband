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
    logic [127:0] x, k ,y, xtemp, ktemp;
    logic valid, out_valid, rst;
    aes_round dut (
        .clk(clock),
        .rst(rst),
        .valid(valid),
        .out_valid(out_valid),
        .data_in(x),
        .round_key(k),
        .data_out(y)
    );

    initial begin
        $dumpfile("aes_round.test.vcd");
        $dumpvars(0, aes_round_tb);
        $display("----- aes_round Unit Test -----");
        file = $fopen(file_path, "r");
        rst = 1;
        valid = 0;
        count = 0;
        {x,k} = '0;
        #10
        rst = 0;
    end

    always_ff @(posedge clock) begin
        // x <= x + 1;
        if(count % 3 == 0) begin
            $fscanf(file, "%h %h", xtemp, ktemp);
        x <= xtemp;
        k <= ktemp;
                valid <= 1;

        end else begin
            {x,k} <= '0;
            valid <= 0;
        end

        $display("%h, %h, %h, %d, %d, %d", x, k, y, valid, out_valid, count);
        count <= count + 1;
       // $display("in: %h", x);
       if (count == 200) begin
            $finish;
        end
    end




endmodule: aes_round_tb
