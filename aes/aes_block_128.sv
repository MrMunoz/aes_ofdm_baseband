module aes_round #(parameter int SIZE = 128)
(
    input wire clock,
    input wire [SIZE - 1:0] data,
    input wire [63:0] nonce,
    input wire [SIZE - 1:0] round_key,
    output logic [SIZE - 1:0]  enc_data
);


    
endmodule: aes_round


module aes_block #(parameter int SIZE = 128)
(
    input wire clock,
    input wire [SIZE - 1:0] data,
    input wire [63:0] nonce,
    input wire [SIZE - 1:0] key,
    output logic [SIZE - 1:0]  enc_data
);

    
    
endmodule: aes_block

