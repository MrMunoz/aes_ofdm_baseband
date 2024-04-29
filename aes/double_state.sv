

module double_state
(
    input logic [127:0] data_in,
    output logic [127:0] data_out
);

    genvar i;
    generate
        for(i = 0; i < 16; i++) begin: double_generate
            double double_i(.x(data_in[(i+1)*8-1:i*8]), .y(data_out[(i+1)*8-1:i*8]));
        end
    endgenerate

endmodule: double_state

module double
    (
    input logic [7:0] x,
    output logic [7:0] y
    );

    assign y = {x[6:4], x[3] ^ x[7], x[2] ^ x[7], x[1], x[0] ^ x[7], x[7]};

endmodule: double
