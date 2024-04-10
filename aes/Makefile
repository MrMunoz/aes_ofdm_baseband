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


clean:
	rm -f *.out *.vcd