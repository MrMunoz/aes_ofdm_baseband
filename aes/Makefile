build:
	iverilog -g2012 -o sbox.out ./sbox.sv ./sbox_tb.sv
run: build
	vvp sbox.out > str.out
clean:
	rm -f *.out *.vcd