

module xor_network
(
    input logic [127:0] state,
    input logic [127:0] double_state,
    input logic [127:0] round_key,
    output logic [127:0] data_out
);

    logic [127:0] temp;

    genvar i;
    generate
        for(i = 0; i < 4; i++) begin: network_generate
            // e_0
            localparam k0 = getk(0, i);
            localparam high_k0 = getHigh(k0);
            localparam low_k0 = getLow(k0);

            localparam k1 = getk(1, i);
            localparam high_k1 = getHigh(k1);
            localparam low_k1 = getLow(k1);

            localparam k2 = getk(2, i);
            localparam high_k2 = getHigh(k2);
            localparam low_k2 = getLow(k2);

            localparam k3 = getk(3, i);
            localparam high_k3 = getHigh(k3);
            localparam low_k3 = getLow(k3);

            localparam k5 = getk(5, i);
            localparam high_k5 = getHigh(k5);
            localparam low_k5 = getLow(k5);

            localparam k10 = getk(10, i);
            localparam high_k10 = getHigh(k10);
            localparam low_k10 = getLow(k10);

            localparam k15 = getk(15, i);
            localparam high_k15 = getHigh(k15);
            localparam low_k15 = getLow(k15);

            assign temp[high_k0: low_k0] = double_state[high_k0: low_k0] ^ double_state[high_k5: low_k5] ^ state[high_k5: low_k5] ^ state[high_k10: low_k10] ^ state[high_k15: low_k15];
            // e_1
            assign temp[high_k1: low_k1] = state[high_k0: low_k0] ^ double_state[high_k5: low_k5] ^ double_state[high_k10: low_k10] ^ state[high_k10: low_k10] ^ state[high_k15: low_k15];
            // e_2
            assign temp[high_k2: low_k2] = state[high_k0: low_k0] ^ state[high_k5: low_k5] ^ double_state[high_k10: low_k10] ^ double_state[high_k15: low_k15] ^ state[high_k15: low_k15];
            // e_3
            assign temp[high_k3: low_k3] = double_state[high_k0: low_k0] ^ state[high_k0: low_k0] ^ state[high_k5: low_k5] ^ state[high_k10: low_k10] ^ double_state[high_k15: low_k15];
        end
    endgenerate

    assign data_out = temp ^ round_key;

    function automatic integer getk;
        input integer inital_offset;
        input integer i;
        getk = (inital_offset + 4 * i) % 16;
    endfunction

    function automatic integer getHigh;
        input integer k;
        getHigh = 127-8*k;
    endfunction

    function automatic integer getLow;
        input integer k;
        getLow = 120-8*k;
    endfunction

endmodule: xor_network
