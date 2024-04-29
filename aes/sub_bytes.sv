`default_nettype none
module sub_bytes
(
    input logic clk,
	input logic rst,
    input logic [127:0] data_in,
    output logic [127:0] data_out
);


    genvar i;
    generate
        for(i = 0; i < 16; i++) begin
            sbox sub_i(.clk(clk), .x(data_in[(i+1)*8-1:i*8]), .y(data_out[(i+1)*8-1:i*8]));
        end
    endgenerate

endmodule: sub_bytes
