

module aes_round
(
    input wire clk,
    input wire reset,
    input wire [127:0] data_in,
    input wire [127:0] round_key,
    output logic [127:0] data_out
);


    // Stage 0 reg
    logic [127:0] state_0;
    always_ff @(posedge clk) begin
        state_0 <= data_in;
    end

    logic [127:0] subBytes_out;
    sub_bytes subBytes(.clk(clk), .data_in(state_0), .data_out(subBytes_out));
 
    logic [127:0] double_subBytes_out;
    double_state double_subBytes(.data_in(subBytes_out), .data_out(double_subBytes_out));

    xor_network xor_net(.state(subBytes_out), .double_state(double_subBytes_out), .round_key(round_key), .data_out(data_out));

endmodule: aes_round


// module aes_block
// (
//     input wire clk,
//     input wire [127:0] data_in,
//     input wire [127:0] key,
//     output logic [127:0]  data_out
// );

// // Initial key xor nonce||counter

// // Reg

// // Stage i  x 9
// // Reg i    x 9

// // Stage 10
    
// endmodule: aes_block

