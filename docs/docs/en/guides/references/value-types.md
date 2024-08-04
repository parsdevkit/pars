---
title: Value Types
---

# Value Types


## Object
- **Description**: The base type for all other types. Every variable is of type `Object`, meaning any variable of any specific type is also an `Object`.
- **Technical Details**: All types, including those defined under `Number`, `Text`, `Boolean`, `Map`, and `Null`, are derived from `Object`.
- **Initial Value**: `none`

## Bit
- **Description**: Represents a binary digit, either 0 or 1.
- **Technical Details**: Bit values are used in low-level operations and bit manipulation.
- **Usage**: Typically used for bitwise operations.
- **Initial Value**: `0`
- **Example**: `Bit value = 1`

## Number

### Int
#### UInt8 (UByte)
- **Description**: Unsigned 8-bit integer.
- **Technical Details**: Ranges from 0 to 255.
- **Usage**: Used for small ranges of non-negative numbers.
- **Initial Value**: `0`
- **Example**: `UInt8 age = 25`

#### Int8 (Byte)
- **Description**: Signed 8-bit integer.
- **Technical Details**: Ranges from -128 to 127.
- **Usage**: Used for small ranges of signed numbers.
- **Initial Value**: `0`
- **Example**: `Int8 temperature = -10`

#### UInt16 (UShort)
- **Description**: Unsigned 16-bit integer.
- **Technical Details**: Ranges from 0 to 65,535.
- **Usage**: Used for larger ranges of non-negative numbers.
- **Initial Value**: `0`
- **Example**: `UInt16 height = 180`

#### Int16 (Short)
- **Description**: Signed 16-bit integer.
- **Technical Details**: Ranges from -32,768 to 32,767.
- **Usage**: Used for larger ranges of signed numbers.
- **Initial Value**: `0`
- **Example**: `Int16 distance = -5000`

#### UInt32 (UInt)
- **Description**: Unsigned 32-bit integer.
- **Technical Details**: Ranges from 0 to 4,294,967,295.
- **Usage**: Used for even larger ranges of non-negative numbers.
- **Initial Value**: `0`
- **Example**: `UInt32 population = 1000000`

#### Int32 (Int)
- **Description**: Signed 32-bit integer.
- **Technical Details**: Ranges from -2,147,483,648 to 2,147,483,647.
- **Usage**: Used for a wide range of signed numbers.
- **Initial Value**: `0`
- **Example**: `Int32 score = 1500`

#### UInt64 (ULong)
- **Description**: Unsigned 64-bit integer.
- **Technical Details**: Ranges from 0 to 18,446,744,073,709,551,615.
- **Usage**: Used for very large ranges of non-negative numbers.
- **Initial Value**: `0`
- **Example**: `UInt64 fileSize = 1234567890123`

#### Int64 (Long)
- **Description**: Signed 64-bit integer.
- **Technical Details**: Ranges from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807.
- **Usage**: Used for very large ranges of signed numbers.
- **Initial Value**: `0`
- **Example**: `Int64 bigNumber = -987654321012345`

#### UInt128
- **Description**: Unsigned 128-bit integer.
- **Technical Details**: Ranges from 0 to 3.4 x 10^38.
- **Usage**: Used for extremely large ranges of non-negative numbers. (Rarely used)
- **Initial Value**: `0`
- **Example**: `UInt128 bigValue = 340282366920938463463374607431768211456`

#### Int128
- **Description**: Signed 128-bit integer.
- **Technical Details**: Ranges from -1.7 x 10^38 to 1.7 x 10^38.
- **Usage**: Used for extremely large ranges of signed numbers. (Rarely used)
- **Initial Value**: `0`
- **Example**: `Int128 largeNumber = -170141183460469231731687303715884105728`

### Float
#### Float16
- **Description**: 16-bit floating-point number.
- **Technical Details**: Provides lower precision but uses less memory.
- **Usage**: Used in specialized applications where memory is a concern.
- **Initial Value**: `0.0`
- **Example**: `Float16 temperature = 22.5f`

#### Float32 (Float)
- **Description**: 32-bit floating-point number (single precision).
- **Technical Details**: Provides a balance between precision and memory usage.
- **Usage**: Commonly used for general floating-point calculations.
- **Initial Value**: `0.0`
- **Example**: `Float32 distance = 3.14f`

#### Float64 (Double)
- **Description**: 64-bit floating-point number (double precision).
- **Technical Details**: Provides higher precision than `Float32`.
- **Usage**: Used when higher precision in calculations is required.
- **Initial Value**: `0.0`
- **Example**: `Float64 pi = 3.141592653589793`

#### Float128
- **Description**: 128-bit floating-point number.
- **Technical Details**: Offers extended precision for high-accuracy calculations.
- **Usage**: Used in scientific and high-precision applications. (Rarely used)
- **Initial Value**: `0.0`
- **Example**: `Float128 preciseValue = 3.1415926535897932384626`

### Decimal
- **Description**: Represents fixed-point numbers with a specific number of decimal places.
- **Technical Details**: Used for exact decimal representation and calculations.
- **Usage**: Ideal for financial calculations and scenarios where exact decimal representation is crucial.
- **Initial Value**: `0.0`
- **Example**: `Decimal price = 199.99m`

## Text
### String
- **Description**: Represents a sequence of characters.
- **Technical Details**: Used for storing and manipulating text.
- **Usage**: Commonly used for handling text data.
- **Initial Value**: `""`
- **Example**: `String message = "Hello, World!"`

### Char
- **Description**: Represents a single character.
- **Technical Details**: Used for operations involving individual characters.
- **Usage**: Useful for processing and manipulating individual characters.
- **Initial Value**: `'\0'`
- **Example**: `Char initial = 'A'`

## Boolean
- **Description**: Represents a logical value, either `true` or `false`.
- **Technical Details**: Used in conditional statements and logical operations.
- **Usage**: Essential for control flow and decision-making in code.
- **Initial Value**: `false`
- **Example**: `Boolean isActive = true`


## Blob
- **Description**: Represents a Binary Large Object, typically used to store binary data such as files, images, or multimedia.
- **Technical Details**: Can hold a large amount of binary data and is often used in database storage or file handling.
- **Usage**: Used for handling and storing binary data.
- **Initial Value**: `none`
- **Example**: `Blob image = loadBlob("path/to/image.jpg")`

## Time
- **Description**: Represents time-related data such as dates, times, or durations.
- **Technical Details**: Can be used to store and manipulate date and time information.
- **Usage**: Ideal for applications that require date and time calculations, scheduling, or time-based data.
- **Initial Value**: `none`
- **Example**: `Time currentTime = getCurrentTime()`


