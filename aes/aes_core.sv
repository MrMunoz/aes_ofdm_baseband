module aes_core
    (
    input logic clk,
	input logic rst,

    output logic data_ready,
    input logic data_valid,
    input logic [127:0] data_in,

    input logic key_valid,
    output logic key_ready,
    input logic [127:0] main_key,

    output logic data_out_valid,
    output logic [127:0] data_out
    );

    logic [127:0] intermediates[10]; // Used as registers implicitly in aes_round
    logic valid_inter[10];
    logic key_store_valid;
    logic [127:0] main_key_store;
    always_ff @(posedge clk) begin
        if(rst) begin
            data_ready <= '0;
            key_ready <= '1;
        end

        if(key_valid) begin
            main_key_store <= main_key;
            key_store_valid <= '1;
            key_ready <= '0;
        end

        //$display("intermediate 10: ")
        data_ready <= keys_done;
    end

    logic [127:0] round_keys[11];
    logic round_keys_valid[11];
    logic keys_done;
    assign keys_done = round_keys_valid[10];

    key_expand keygen_first
                (
                .clk(clk),
                .rst(rst),
                .valid(key_store_valid),
                .out_valid(round_keys_valid[1]),
                .round(0),
                .key_in(main_key_store),
                .key_out(round_keys[1])
                );

    genvar key_round;
    generate
        for(key_round = 1; key_round < 10; key_round++) begin: key_generate
            key_expand keygen_i
                (
                .clk(clk),
                .rst(rst),
                .valid(round_keys_valid[key_round]),
                .out_valid(round_keys_valid[key_round+1]),
                .round(key_round),
                .key_in(round_keys[key_round]),
                .key_out(round_keys[key_round+1])
                );
        end
    endgenerate

    aes_round round_first(
        .clk(clk),
        .rst(rst),
        .valid(data_valid),
        .out_valid(valid_inter[1]),
        .data_in(data_in),
        .round_key(round_keys[1]),
        .data_out(intermediates[1])); // Final reg is intermediates[9]

    genvar i;
    generate
        for(i = 1; i < 9; i++) begin: round_generate
            aes_round round_i(.clk(clk), .rst(rst), .valid(valid_inter[i]), .out_valid(valid_inter[i+1]), .data_in(intermediates[i]), .round_key(round_keys[i]), .data_out(intermediates[i+1])); // Final reg is intermediates[9]
        end
    endgenerate

    aes_final_round round_last(.clk(clk), .rst(rst), .valid(valid_inter[9]), .out_valid(data_out_valid), .data_in(intermediates[9]), .round_key(round_keys[10]), .data_out(data_out));


endmodule: aes_core
