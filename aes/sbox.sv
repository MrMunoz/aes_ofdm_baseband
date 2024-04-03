module sbox
    (
    input wire clk,
    input wire [7:0] x,
    output logic [7:0] y
    );

    // Isomorphic mapping

    

    // Reg

    // Stage 1

    // Reg

    // Stage 2

    // Reg

    // Stage 3

    // Reg

    // Inverse Mapping and Affine

    // Reg

endmodule: sbox

module gf_2_4_lamba_mult
    (
    input wire [3:0] x,
    output logic [3:0] y
    );

    assign y = {x[2] ^ x[0], x[3] ^ x[2] ^ x[1] ^ x[0], x[3], x[2]};

endmodule: gf_2_4_lamba_mult

module gf_2_4_square
    (
    input wire [3:0] x,
    output logic [3:0] y
    );

    assign y = {x[3], x[3] ^ x[1], x[2] ^ x[1], x[3] ^ x[1] ^ x[0]};

endmodule: gf_2_4_square

module isomorphic_map
    (
    input wire [7:0] x,
    output logic [7:0] y
    );

    always_comb begin
        y[7] = x[7]^x[6]^x[1];
        y[6] = x[6]^x[3]^x[1];
        y[5] = x[6]^x[5]^x[4]^x[3]^x[0];
        y[4] = x[6]^x[5]^x[1]^x[0];
        y[3] = x[6]^x[5]^x[4]^x[2]^x[0];
        y[2] = x[5]^x[4]^x[2]^x[0];
        y[1] = x[6]^x[5]^x[4]^x[3]^x[1]^x[0];
        y[0] = x[2]^x[0];
    end

endmodule: isomorphic_map

module affine_inverse_iso
    (
    input wire [7:0] x,
    output logic [7:0] y
    );

    always_comb begin
        y[7] = x[7]^x[6]^x[3]^x[0];
        y[6] = x[5]^x[0];
        y[5] = x[3]^x[2]^x[1]^x[0];
        y[4] = x[5]^x[4]^x[0];
        y[3] = x[7]^x[6]^x[5]^x[1]^x[0];
        y[2] = x[7]^x[0];
        y[1] = x[7]^x[5]^x[4]^x[3]^x[2]^x[1];
        y[0] = x[7]^x[6]^x[5];
        y ^= 'h63;
    end    

endmodule: affine_inverse_iso