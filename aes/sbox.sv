`default_nettype none

module sbox
    (
    input wire clk,
    input wire [7:0] x,
    output logic [7:0] y
    //output logic [7:0] my_x
    );

    // Isomorphic mapping

    logic [7:0] mapped;
    isomorphic_map map(.x(x), .y(mapped));

    // Reg
    logic [3:0] high_0, low_0, h_xor_l_0;
    //logic [7:0] x_0;
    always_ff @(posedge clk ) begin
        high_0 <= mapped[7:4];
        h_xor_l_0 <= mapped[7:4] ^ mapped[3:0];
        low_0 <= mapped[3:0];
        //x_0 <= x;
    end

    // Stage 1
    logic [3:0] stage_1_lambda, stage_1_square;
    gf_2_4_square square(.x(high_0), .y(stage_1_square));
    gf_2_4_lamba_mult lambda(.x(stage_1_square), .y(stage_1_lambda));
    // gf_2_4_lamba_square_comp comp(.x(high_0), .y(stage_1_map));

    logic [3:0] stage_1_prod;
    spem stage_1_mul(.H(h_xor_l_0), .B(low_0), .prod(stage_1_prod));

    // Reg
    logic [3:0] high_1, h_xor_l_1, prod_xor_map_1;
    //logic [7:0] x_1;
    always_ff @(posedge clk ) begin
        high_1 <= high_0;
        h_xor_l_1 <= h_xor_l_0;
        prod_xor_map_1 <= stage_1_lambda ^ stage_1_prod;
        //x_1 <= x_0;
    end

    // Stage 2

    logic [3:0] inv;
    simpl inverse(.x(prod_xor_map_1), .y(inv));

    // Reg
    logic [3:0] high_2, h_xor_l_2, inv_2;
    //logic [7:0] x_2;
    always_ff @(posedge clk ) begin
        high_2 <= high_1;
        h_xor_l_2 <= h_xor_l_1;
        inv_2 <= inv;
       // x_2 <= x_1;
    end

    // Stage 3
    logic [3:0] high_prod;
    spem high_mul(.H(high_2), .B(inv_2), .prod(high_prod));

    logic [3:0] low_prod;
    spem low_mul(.H(h_xor_l_2), .B(inv_2), .prod(low_prod));

    // Reg

    logic [3:0] high_3, low_3;
    //logic [7:0] x_3;
    always_ff @(posedge clk ) begin
        high_3 <= high_prod;
        low_3 <= low_prod;
        //x_3 <= x_2;
    end


    // Inverse Mapping and Affine

    logic [7:0] affine_inverse_iso_map;
    affine_inverse_iso aff(.x({high_3, low_3}), .y(affine_inverse_iso_map));

    // Reg

    logic [7:0] out;
    //logic [7:0] x_4;
    always_ff @(posedge clk ) begin
        out <= affine_inverse_iso_map;
        y <= out;
        //x_4 <= x_3;
       // my_x <= x_4;
    end

endmodule: sbox

// module gf_2_4_lamba_square_comp
//     (
//     input wire [3:0] x,
//     output logic [3:0] y
//     );

//     assign y = {x[0], x[3] ^ x[2] ^ x[1] ^ x[0], x[3], x[3] ^ x[1]};

// endmodule: gf_2_4_lamba_square_comp

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

    assign y = {x[3], x[3] ^ x[2], x[2] ^ x[1], x[3] ^ x[1] ^ x[0]};

endmodule: gf_2_4_square

module isomorphic_map
    (
    input wire [7:0] x,
    output logic [7:0] y
    );

    always_comb begin
        y[7] = x[7]^x[5];
        y[6] = x[7]^x[6]^x[4]^x[3]^x[2]^x[1];
        y[5] = x[7]^x[5]^x[3]^x[2];
        y[4] = x[7]^x[5]^x[3]^x[2]^x[1];
        y[3] = x[7]^x[6]^x[2]^x[1];
        y[2] = x[7]^x[4]^x[3]^x[2]^x[1];
        y[1] = x[6]^x[4]^x[1];
        y[0] = x[6]^x[1]^x[0];
    end

endmodule: isomorphic_map

module affine_inverse_iso
    (
    input wire [7:0] x,
    output logic [7:0] y
    );

    always_comb begin
        y[7] = x[7]^x[3]^x[2];
        y[6] = x[7]^x[6]^x[5]^x[4];
        y[5] = x[7]^x[2];
        y[4] = x[7]^x[4]^x[1]^x[0];
        y[3] = x[2]^x[1]^x[0];
        y[2] = x[6]^x[5]^x[4]^x[3]^x[2]^x[0];
        y[1] = x[7]^x[0];
        y[0] = x[7]^x[6]^x[2]^x[1]^x[0];
        y ^= 'h63;
    end    

endmodule: affine_inverse_iso