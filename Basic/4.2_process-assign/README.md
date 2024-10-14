# Compiler verilog source file
```
$ iverilog -o testbench.vvp process-assign.v
```

# Create vcd file
```
$ vvp testbench.vvp
```

# Gtkwave
```
$ gtkwave testbench.vcd
```