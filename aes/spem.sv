`default_nettype none
// A GF(2^4) multiplier
module spem
    (
    input logic [3:0] H,
    input logic [3:0] B,
    output logic [3:0] prod
    );

    logic [1:0] w_0, w_1, w_2;

    w0 block0(.H_H(H[3:2]), .B_H(B[3:2]), .w(w_0));

    w1 block1(.H(H), .B(B), .w(w_1));

    w2 block2(.H_L(H[1:0]), .B_L(B[1:0]), .w(w_2));

    assign prod = {w_1 ^ w_2, w_0 ^ w_2};
endmodule: spem

module w0
    (
    input logic [3:2] H_H,
    input logic [1:0] B_H,
    output logic [1:0] w
    );

    always_comb begin
        case (B_H)
            2'b00: w = 2'b00;
            2'b01: w = {H_H[3]^H_H[2], H_H[3]};
            2'b10: w = {H_H[2], H_H[3]^H_H[2]};
            2'b11: w = H_H;
        endcase
    end


endmodule: w0

module w1
    (
    input logic [3:0] H,
    input logic [3:0] B,
    output logic [1:0] w
    );

    logic [1:0] H_xor;
    logic [1:0] B_xor;

    always_comb begin
        H_xor = H[3:2] ^ H[1:0];
        B_xor = B[3:2] ^ B[1:0];

        case (B_xor)
            2'b00: w = 2'b00;
            2'b01: w = H_xor;
            2'b10: w = {H_xor[1]^H_xor[0], H_xor[1]};
            2'b11: w = {H_xor[0], H_xor[1]^H_xor[0]};
        endcase
    end

endmodule: w1

module w2
    (
    input logic [1:0] H_L,
    input logic [1:0] B_L,
    output logic [1:0] w
    );

    always_comb begin
        case (B_L)
            2'b00: w = 2'b00;
            2'b01: w = H_L;
            2'b10: w = {H_L[1]^H_L[0], H_L[1]};
            2'b11: w = {H_L[0], H_L[1]^H_L[0]};
        endcase
    end

endmodule: w2