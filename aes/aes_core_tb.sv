`timescale 1ns/1ps
`default_nettype none
module aes_core_tb ();
    logic clk;

    always begin
        #2.5;
        clk = 0;
        #2.5;
        clk = 1;
    end

    int count, file;
    string file_path = "testvectors/aes_core.txt";
	logic rst;
    logic data_ready;
    logic data_valid;
    logic [127:0] data_in;
    logic key_valid;
    logic key_ready;
    logic [127:0] main_key;
    logic data_out_valid;
    logic [127:0] data_out;
    aes_core dut
        (
        .clk(clk),
        .rst(rst),
        .data_ready(data_ready),
        .data_valid(data_valid),
        .data_in(data_in),
        .key_valid(key_valid),
        .key_ready(key_ready),
        .main_key(main_key),
        .data_out_valid(data_out_valid),
        .data_out(data_out)
        );

    initial begin
        $dumpfile("aes_core.test.vcd");
        $dumpvars(0, aes_core_tb);
        $display("----- aes_core Unit Test -----");
        //file = $fopen(file_path, "r");
        rst = 1;
        data_valid = '0;
        data_in = '0;
        key_valid = '0;
        main_key = '0;
        #10
        rst = 0;
    end

    always_ff @(posedge clk) begin
        // x <= x + 1;
        if(key_ready) begin
            $display("Init key");
            main_key <= 128'h2b7e151628aed2a6abf7158809cf4f3c;
            key_valid <= 1;
        end else begin
            main_key <= '0;
            key_valid <= '0;
        end

        if(data_ready) begin
            $display("data ready on cycle %d", count);
            data_valid<= '1;
            data_in<= 128'h3243f6a8885a308d313198a2e0370734;
        end else begin
            data_valid<='0;
            data_in<='0;
        end


        if(data_out_valid) begin

            $display("data_out on cycle %d: %h", count, data_out);
            $finish;
        end

        count <= count + 1;
       if (count == 200) begin
            $finish;
        end
    end




endmodule: aes_core_tb
