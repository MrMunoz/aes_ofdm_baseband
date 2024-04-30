module key_expand
    (
    input logic clk,
    input logic rst,
    input logic valid,
    output logic out_valid,
    input logic [3:0] round,
    input logic [127:0] key_in,
    output logic [127:0] key_out
    );

// K(r-1,c) + Sbox( Rword( K(r-1,c+3) ) ) + Rcon(r-1) c = 1
// K(r, c-1) + K(r-1, c) c=2,3,4

logic[31:0] c1, c2 ,c3, c4;

assign c1 = key_in[127:96];
assign c2 = key_in[95:64];
assign c3 = key_in[63:32];
assign c4 = key_in[31:0];

logic [31:0] temp;
// Sbox( Rword( K(r-1,4)
logic valid_temp[3];
sbox s1(.clk(clk), .rst(rst), .valid(valid), .out_valid(out_valid), .x(c4[23:16]), .y(temp[31:24]));
sbox s2(.clk(clk), .rst(rst), .valid(valid), .out_valid(valid_temp[0]), .x(c4[15:8]), .y(temp[23:16]));
sbox s3(.clk(clk), .rst(rst), .valid(valid), .out_valid(valid_temp[1]), .x(c4[7:0]), .y(temp[15:8]));
sbox s4(.clk(clk), .rst(rst), .valid(valid), .out_valid(valid_temp[2]), .x(c4[31:24]), .y(temp[7:0]));

assign key_out[127:96] = c1 ^ temp ^ rcon(round); // c = 1
assign key_out[95:64] = c1 ^ temp ^ rcon(round) ^ c2;
assign key_out[63:32] = c1 ^ temp ^ rcon(round) ^ c2 ^ c3;
assign key_out[31:0] = c1 ^ temp ^ rcon(round) ^ c2 ^ c3 ^ c4;


endmodule: key_expand


function [31:0]	rcon;
      input	[3:0]	round;
      case(round)
         4'h0: rcon=32'h01_00_00_00;
         4'h1: rcon=32'h02_00_00_00;
         4'h2: rcon=32'h04_00_00_00;
         4'h3: rcon=32'h08_00_00_00;
         4'h4: rcon=32'h10_00_00_00;
         4'h5: rcon=32'h20_00_00_00;
         4'h6: rcon=32'h40_00_00_00;
         4'h7: rcon=32'h80_00_00_00;
         4'h8: rcon=32'h1b_00_00_00;
         4'h9: rcon=32'h36_00_00_00;
         default: rcon=32'h00_00_00_00;
       endcase

endfunction
