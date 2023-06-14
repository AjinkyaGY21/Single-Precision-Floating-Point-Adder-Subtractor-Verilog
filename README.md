# Single-Precision-Floating-Point-Adder-Subtractor-in-Verilog

This repository contains the Verilog implementation of a floating-point adder/subtractor designed as ECN-252 course project. The project focuses on designing a module that can perform addition and subtraction operations on single-precision floating-point numbers, considering special cases such as underflow, overflow, and NaN.


## Features

- Addition and subtraction operations on single-precision floating-point numbers
- Support for special cases: NaN, underflow, and overflow
- Proper handling of denormalized numbers and infinity



## Design Overview

The floating-point adder/subtractor module takes two 32-bit inputs representing single-precision floating-point numbers. It performs addition or subtraction based on the values of the inputs and handles special cases such as NaN, underflow, and overflow.

The design extracts the sign, exponent, and mantissa fields from the inputs and checks for special cases. In case of NaN inputs, the output is set as NaN. For infinity inputs or zero inputs, the output is computed accordingly. For normal operation, the module adds or subtracts the mantissas, checks for overflow or underflow, and normalizes the result by adjusting the exponent.
