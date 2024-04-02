module shift_rows 
    (
    input wire clk,
    input wire [127: 0] data_in,
    output logic [127: 0] data_out
    );

    always_ff @(posedge clk) begin
        // Row 1
        data_out[127:96] <= {data_in[127:96]}; // No shift
        // Row 2
        data_out[95:64] <= {data_in[87:64], data_in[95:88]}; // Shift 1
        // Row 3
        data_out[63:32] <= {data_in[47:32], data_in[63:48]}; // Shift 2
        // Row 4
        data_out[31:0] <= {data_in[7:0], data_in[31:8]}; // Shift 3

    end

    
endmodule: shift_rows