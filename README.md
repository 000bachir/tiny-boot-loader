# 16-Bit Bootloader (NASM)

A simple x86 bootloader written in 16-bit Assembly using NASM. This project demonstrates the fundamentals of bootloader development, including screen manipulation, cursor positioning, stack initialization, and text output using BIOS interrupts.

## Overview

When a computer starts, the BIOS loads the first sector of the bootable device into memory at address `0x7C00` and transfers execution to it. This first sector is called the **boot sector** and is limited to **512 bytes**.

Since the processor starts in **16-bit Real Mode**, a bootloader must initially be written in 16-bit assembly. This is a required first step before transitioning to more advanced stages such as:

* Loading a second-stage bootloader
* Entering 32-bit Protected Mode
* Entering 64-bit Long Mode
* Loading and starting an operating system kernel

This project focuses on understanding the boot process and interacting directly with BIOS services.

## Features

* Initializes data and stack segments
* Clears the screen using BIOS interrupt `INT 10h`
* Moves the cursor to a specified position
* Prints a null-terminated string to the display
* Demonstrates function calls and stack-based argument passing
* Produces a valid boot sector with the `0xAA55` boot signature

## Project Structure

```text
boot.asm
```

Main components:

* `clearscreen` – Clears the text-mode display.
* `movecursor` – Moves the cursor to a specific row and column.
* `print` – Outputs a null-terminated string using BIOS teletype services.
* `msg` – The string displayed on the screen.

## Requirements

### Fedora Linux

Install NASM:

```bash
sudo dnf install nasm
```

Install QEMU:

```bash
sudo dnf install qemu-system-x86
```

QEMU is used to emulate an x86 machine and run the bootloader without needing to write it to a physical USB drive or reboot the host machine.

## Building

Assemble the bootloader into a raw binary:

```bash
nasm -f bin boot.asm -o boot.bin
```

## Running

Run the boot sector with QEMU:

```bash
qemu-system-i386 -drive format=raw,file=boot.bin
```

A virtual machine window will appear and execute the bootloader exactly as a BIOS would.

## Technical Notes

### Why 16-Bit Assembly?

The x86 CPU starts in **Real Mode** immediately after reset. In this mode:

* Only 16-bit instructions are available by default.
* Memory addressing uses segment:offset addressing.
* BIOS interrupts can be used for screen output, keyboard input, and disk access.

Because the BIOS executes the boot sector in Real Mode, every bootloader must begin as a 16-bit program before it can switch the processor into more advanced operating modes.

### Boot Sector Layout

A valid boot sector must:

* Be exactly 512 bytes long.
* End with the boot signature:

```assembly
dw 0xAA55
```

Without this signature, the BIOS will not treat the sector as bootable.

## Learning Goals

This project was created to understand:

* The x86 boot sequence
* Real Mode programming
* BIOS interrupts
* Segment registers (`CS`, `DS`, `SS`)
* Stack management
* Low-level memory addressing
* Function calls in Assembly

## Future Improvements

* Keyboard input support
* Disk sector loading
* Second-stage bootloader
* Protected Mode transition
* Simple kernel loading
* Basic command interface

## References

* Intel Software Developer Manuals
* NASM Documentation
* OSDev Wiki
* BIOS Interrupt Reference

