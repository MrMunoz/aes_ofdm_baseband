
/*
    Implements inverse of x over GF(2^4)
*/
module simpl
    (
    input wire [3:0] x,
    output logic [3:0] y
    );
    
always_comb begin
    y[0] = x[3]&x[2]&x[1] ^ x[3]&x[2]&x[0] ^ x[3]&x[1] 
         ^ x[3]&x[1]&x[0] ^ x[3]&x[0]      ^ x[2] 
         ^ x[2]&x[1]      ^ x[2]&x[1]&x[0] ^ x[1]
         ^ x[0];

    y[1] = x[3]&x[2]&x[1] ^ x[3]&x[1]&x[0] ^ x[3]
         ^ x[2]           ^ x[2]&x[0]      ^ x[1];

    y[2] = x[3]&x[2]&x[1] ^ x[3]&x[2]&x[0] ^ x[3]&x[0]
         ^ x[2]           ^ x[2]&x[1];
    
    y[3] = x[3]&x[0]      ^ x[3]&x[2]&x[1] ^ x[3] 
         ^ x[2];

end

endmodule: simpl