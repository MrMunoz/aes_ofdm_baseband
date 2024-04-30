
module sub_bytes
(
    input logic clk,
	input logic rst,
    input logic valid,
    output logic out_valid,
    input logic [127:0] data_in,
    output logic [127:0] data_out
);

    sbox sub_i(.clk(clk), .rst(rst), .valid(valid), .out_valid(out_valid), .x(data_in[7:0]), .y(data_out[7:0]));
    logic out_valid_temp[15];

    genvar i;
    generate
        for(i = 1; i < 16; i++) begin: sub_generate
            sbox sub_i(.clk(clk), .rst(rst), .valid(valid), .out_valid(out_valid_temp[i-1]), .x(data_in[(i+1)*8-1:i*8]), .y(data_out[(i+1)*8-1:i*8]));
        end
    endgenerate

endmodule: sub_bytes
