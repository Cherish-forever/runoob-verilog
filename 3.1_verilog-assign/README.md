# Compiler verilog source file
```
$ iverilog -o testbench.vvp full_adder1.v
```

# Create vcd file
```
$ vvp testbench.vvp
```

# Gtkwave
```
$ gtkwave testbench.vcd
```