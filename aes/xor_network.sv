`default_nettype none

module xor_network
(
    input wire [127:0] state,
    input wire [127:0] double_state,
    input wire [127:0] round_key,
    output logic [127:0] data_out
);
 
    genvar i;
    generate 
        for(i = 0; i < 4; i++) begin 
            // S(0 + 4*i % 16)
            // S(5 + 4*i % 16)
            // S(10 + 4*i % 16)
            // S(15 + 4*i % 16)
        end
    endgenerate

endmodule: xor_network