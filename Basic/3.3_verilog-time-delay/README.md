# Compiler verilog source file
```
$ iverilog -o testbench.vvp time_delay.v testbench.v
```

# Create vcd file
```
$ vvp testbench.vvp
```

# Gtkwave
```
$ gtkwave testbench.vcd
```