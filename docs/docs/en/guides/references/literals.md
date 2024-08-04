---
title: Literals
---

# Literals

## Number Literals
### Integer Literals
- **Description**: Represents whole numbers without any fractional or decimal component.
- **Technical Details**: Can be positive or negative. Typically represented in decimal (base 10), but can also be in binary (base 2), octal (base 8), or hexadecimal (base 16).
- **Usage**: Used for counting, indexing, and basic arithmetic operations.
- **Example**: 
    ```pseudocode
    Int positiveInt = 123;
    Int negativeInt = -456;
    Int binaryInt = 0b1010;   // Binary literal
    Int octalInt = 0123;      // Octal literal
    Int hexInt = 0x1A3;       // Hexadecimal literal
    ```

### Floating-point Literals
- **Description**: Represents numbers with fractional or decimal components.
- **Technical Details**: Can be positive or negative. Typically represented in decimal notation or scientific notation.
- **Usage**: Used for calculations requiring precision with decimal points, such as scientific and financial computations.
- **Example**: 
    ```pseudocode
    Float simpleFloat = 123.45;
    Float negativeFloat = -67.89;
    Float scientificFloat = 1.23e4;   // Scientific notation (1.23 x 10^4)
    ```

## Text Literals
### Character Literals
- **Description**: Represents a single character enclosed in single quotes.
- **Technical Details**: Can include letters, digits, symbols, or escape sequences.
- **Usage**: Used to store and manipulate individual characters.
- **Example**: 
    ```pseudocode
    Char letter = 'A';
    Char digit = '7';
    Char symbol = '#';
    Char escapeSequence = '\n';   // Newline character
    ```

### String Literals
- **Description**: Represents a sequence of characters enclosed in double quotes.
- **Technical Details**: Can include letters, digits, symbols, and escape sequences. Supports concatenation and various string operations.
- **Usage**: Used to store and manipulate text data.
- **Example**: 
    ```pseudocode
    String greeting = "Hello, world!";
    String multiline = "This is line 1.\nThis is line 2.";
    String concatenated = "Hello, " + "world!";
    ```

## Boolean Literals
- **Description**: Represents logical values indicating `true` or `false`.
- **Technical Details**: Used in conditional statements and logical operations.
- **Usage**: Indicates the truthiness or falsiness of a condition.
- **Example**: 
    ```pseudocode
    Boolean isActive = true;
    Boolean isComplete = false;
    if (isActive) {
        // Perform some action
    }
    ```


## Null Literals
- **Description**: Represents the absence of a value or a non-existent reference. `none`
- **Technical Details**: Indicates that a variable does not currently hold a valid value.
- **Usage**: Used to signify uninitialized or optional values.
- **Example**: 
    ```pseudocode
    Object value = none;
    if (value == none) {
        // Handle the absence of a value
    }
    ```