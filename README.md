# VHDL Calculator Project
Project for MECHENG 371 - Digital Circuit Design

## Authors:
- Alex Ruddell (2019)
- Morgan Davies (2019)

## Project Description
In this project, a FPGA with I/O peripherals was used to design a Calculator in Verilog HDL language. This calculator implements the addition, subtraction, multiplication, and division operations of a normal calculator.

## Project Information

### How to run the project.
1. Launch the Quartus program
2. Navigate to Open an existing project
3. Select the file Calculator.qpf
4. Compile the program code
5. Navigate to the Tools > Programmer window
6. Select the USB-Blaster hardware setup and select “Start” to program to the DE2 board.

### How to use the project.
#### User Inputs:
The DE2 board models calculator inputs using the 4x4 hex keypad and the 4x blue push buttons. 
The keys 0 - 9 represent the digit inputs 0 - 9 as you would assume. Keys A through F are explained below:
- A: Reset	Sends  the calculator to its initial state
- B: Equals	Performs the loaded calculation
- C: Divide	Enters the division operator
- D: Multiply	Enters the multiplication operator
- E: Subtract	Enters the subtraction operator
- F: Add		Enters the addition operator
- PB0: Backspace		Deletes the most recent digit entered on the current number
- PB1: Memory Set		Saves the current number into the memory
- PB2: Memory Load	Loads the stored memory to the current number
- PB3: Memory Clear	Clears the stored memory

#### User Outputs:
Key presses and calculation outputs will be fed back to the user through the 8x hexadecimal displays.

#### Operation:
A calculation is structured as follows:
> first sign, first number, operator, second sign, second number, equals

Upon a fresh reset of the board, data is entered into a calculation in the following order…
- The sign of the first number (toggled through the E key)
- The first number (up to 3 digits in length)
- The calculation operator
- The sign of the second number (toggled through the E key)
- The second number (up to 3 digits in length)
- The equals indicator

After the equals button is pressed, the calculation is performed and the result displayed to the user. 
To perform a new calculation, a quick press of the Reset button will clear the program. 
Note that pressing reset will not clear the memory that has been specifically saved by the user. 
