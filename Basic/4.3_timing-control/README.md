# Compiler verilog source file
```
$ iverilog -o testbench.vvp timing-control.v
```

# Create vcd file
```
$ vvp testbench.vvp
```

# Gtkwave
```
$ gtkwave testbench.vcd
```