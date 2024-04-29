// Round 10 omits the mixColumns stage
module aes_final_round
(
    input logic clk,
	input logic rst,
    input logic [127:0] data_in,
    input logic [127:0] round_key,
    output logic [127:0] data_out
);


    // Stage 0 reg
    logic [127:0] state_0;
    always_ff @(posedge clk) begin
        if(rst) begin
            state_0 <= '0;
        end else begin
            state_0 <= data_in;
        end
    end

    logic [127:0] subBytes_out;
    sub_bytes subBytes(.clk(clk), .data_in(state_0), .data_out(subBytes_out));

    logic [127:0] shift_rows_out;
    shift_rows shiftRows(.data_in(subBytes_out), .data_out(shift_rows_out));

    always_comb begin
        data_out = shift_rows_out ^ round_key;
    end

endmodule: aes_final_round

