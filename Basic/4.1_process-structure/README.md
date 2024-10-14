# Compiler verilog source file
```
$ iverilog -o always.vvp always.v
$ iverilog -o initial.vvp initial.v
```

# Create vcd file
```
$ vvp always.vvp
$ vvp initial.vvp
```

# Gtkwave
```
$ gtkwave always.vcd
$ gtkwave initial.vcd
```