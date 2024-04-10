build_sbox:
	iverilog -g2012 -o sbox.out ./sbox.sv ./sbox_tb.sv ./simpl.sv ./spem.sv
run_sbox: build_sbox
	vvp sbox.out > str_sbox.out

build_simpl:
	iverilog -g2012 -o simpl.out ./simpl.sv ./simpl_tb.sv 
run_simpl: build_simpl
	vvp simpl.out > str_simpl.out

build_spem:
	iverilog -g2012 -o spem.out ./spem.sv ./spem_tb.sv 
run_spem: build_spem
	vvp spem.out > str_spem.out

build_sub_bytes:
	iverilog -g2012 -o sub_bytes.out ./sub_bytes.sv ./sub_bytes_tb.sv ./sbox.sv ./simpl.sv ./spem.sv
run_sub_bytes: build_sub_bytes
	vvp sub_bytes.out > str_sub_bytes.out



clean:
	rm -f *.out *.vcd 