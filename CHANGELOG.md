# Change Log

All notable changes to the "verilog-highlight" extension will be documented in this file.

Check [Keep a Changelog](http://keepachangelog.com/) for recommendations on how to structure this file.


## [0.0.8] - 2023-04-18

### Fixes

1. Allow constant expression in declaration
   ```verilog
   module temp;
     reg a = 'd123; // A.2.2.1 real_type and variable_type can include a constant_expression
     real b = 3770;
     // A.2.8 block_real_type and block_variable_type does not include constant_expressions,
     // but current implementation allows it for simplicity.
   endmodule
   ```

## [0.0.7] - 2022-05-10

### Fixes

1. Fix port declaration start with `input`, `output`, `inout`

## [0.0.6] - 2022-01-26

### Enhancements

1. Match incomplete declarations.
   ```verilog
   module test;
   // incomplete register declaration
   reg
   // some comments
   endmodule
   ```

## [0.0.4] - 2022-01-07

### Fixes

1. Fix function call in rvalue of continuous assignment

## [0.0.3] - 2021-12-17

### Enhancements

1. Highlights verilog code blocks inside markdown

### Fixes

1. Stop some keywords from being tokenized as module type

## [0.0.2] - 2021-12-17

### Fixes

1. Fix typo in keyword (medium)

## [0.0.1]

- Initial release
