# VHDL Encryption-Decryption System 🔐

## Overview

This project is a laboratory exercise for the ECE 410 course, focusing on combinational logic design using VHDL. The goal is to create an encryption-decryption system that processes an 8-bit message, ensuring that the message corresponds to a capital letter before applying encryption and decryption techniques.

## Table of Contents

- [Features](#features)
- [System Design](#system-design)
  - [ASCII Verification](#ascii-verification)
  - [Barrel Shifter](#barrel-shifter)
  - [XOR Encryption/Decryption](#xor-encryptiondecryption)
  - [Final Conversion](#final-conversion)
- [Usage](#usage)
- [Requirements](#requirements)
- [Acknowledgments](#acknowledgments)

## Features ✨

- **ASCII Verification**: Ensures the input is an uppercase letter (A-Z).
- **8-bit Barrel Shifters**: Shifts the message based on a 4-bit key that indicates direction and magnitude for added security against man-in-the-middle attacks.
- **XOR Encryption/Decryption**: Encrypts and decrypts the message using an 8-bit key.
- **Lowercase Conversion**: Converts the final message from uppercase to lowercase.

## System Design 🛠️

### ASCII Verification

The first step in the process checks whether the 8-bit input corresponds to an ASCII value representing a capital letter (A-Z). If the input does not meet this criterion, all output bits are 0.

### Barrel Shifter

The system includes an 8-bit barrel shifter that operates based on a 4-bit key:
- The key determines the direction (left or right) and the number of positions to shift the message.

### XOR Encryption/Decryption

An 8-bit XOR block performs the encryption and decryption:
- The system takes an 8-bit key and applies the XOR operation with the shifted message.

### Final Conversion

After the XOR operation, the resulting 8-bit message is converted from its uppercase representation to its lowercase form, revealing the final output.

## Usage 📚

1. **Compile the VHDL code**: Use a VHDL simulator to compile the provided files.
2. **Run provided testbench files**: Observe the output message after processing each input.

## Requirements ✅

- VHDL simulator (e.g., ModelSim, Vivado)
- Basic understanding of VHDL and combinational logic design
- ECE 410 course materials for context and reference

## Acknowledgments 🙏

This project was completed as part of the ECE 410 course, focusing on practical applications of combinational logic design. Special thanks to the course instructors and fellow students for their support and collaboration.
