
module aes_round
(
    input logic clk,
	input logic rst,
    input logic valid,
    output logic out_valid,
    input logic [127:0] data_in,
    input logic [127:0] round_key,
    output logic [127:0] data_out
);


    // Stage 0 reg
    logic [127:0] state_0;
    logic valid_0;
    always_ff @(posedge clk) begin
        if(rst) begin
            state_0 <= '0;
            valid_0 <= '0;
        end else if(valid )begin
            state_0 <= data_in;
        end

        valid_0 <= valid;
    end

    logic [127:0] subBytes_out;
    logic out_valid_temp;
    sub_bytes subBytes(.clk(clk), .rst(rst), .valid(valid_0), .out_valid(out_valid_temp), .data_in(state_0), .data_out(subBytes_out));

    logic [127:0] double_subBytes_out;
    double_state double_subBytes(.data_in(subBytes_out), .data_out(double_subBytes_out));

    logic [127:0] xor_net_out;
    xor_network xor_net(.state(subBytes_out), .double_state(double_subBytes_out), .round_key(round_key), .data_out(xor_net_out));

    always_ff @(posedge clk) begin
        if(rst) begin
            data_out <= '0;
            out_valid <= '0;
        end else begin
            data_out <= xor_net_out;
        end
        out_valid <= out_valid_temp;
    end

endmodule: aes_round
