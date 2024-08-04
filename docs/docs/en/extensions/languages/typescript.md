---
title: TypeScript
---

# TypeScript

## Overview

TypeScript is a strongly typed superset of JavaScript that compiles to plain JavaScript. It is developed and maintained by Microsoft, and it brings optional static types, classes, and interfaces to JavaScript, making it suitable for large-scale application development.

## Supported Versions

* TypeScript 3.x
* TypeScript 4.x
* TypeScript 5.x

## Data Type Correspondence

| Pars Data Type | TypeScript Data Type | Description                                              |
|----------------|-----------------------|----------------------------------------------------------|
| Object         | Object                | The base type for all other types.                       |
| Bit            | boolean               | Represents a binary digit, either 0 or 1.                |
| UInt8 (UByte)  | number                | Unsigned 8-bit integer.                                  |
| Int8 (Byte)    | number                | Signed 8-bit integer.                                    |
| UInt16 (UShort)| number                | Unsigned 16-bit integer.                                 |
| Int16 (Short)  | number                | Signed 16-bit integer.                                   |
| UInt32 (UInt)  | number                | Unsigned 32-bit integer.                                 |
| Int32 (Int)    | number                | Signed 32-bit integer.                                   |
| UInt64 (ULong) | number                | Unsigned 64-bit integer.                                 |
| Int64 (Long)   | number                | Signed 64-bit integer.                                   |
| UInt128        | number                | Unsigned 128-bit integer.                                |
| Int128         | number                | Signed 128-bit integer.                                  |
| Float16        | number                | 16-bit floating-point number.                            |
| Float32 (Float)| number                | 32-bit floating-point number (single precision).         |
| Float64 (Double)| number               | 64-bit floating-point number (double precision).         |
| Float128       | number                | 128-bit floating-point number.                           |
| Decimal        | number                | Represents fixed-point numbers with specific decimal places. |
| String         | string                | Represents a sequence of characters.                     |
| Char           | string                | Represents a single character.                           |
| Boolean        | boolean               | Represents a logical value, either `true` or `false`.    |
| Blob           | Blob                  | Represents a Binary Large Object.                        |
| Time           | Date                  | Represents time-related data such as dates, times, or durations. |

**Notes:**

- Some types such as `UInt128`, `Int128`, `Float16`, and `Float128` do not have direct equivalents in TypeScript. They are represented using the closest available type, `number`.
- `Blob` is represented as a `Blob` in TypeScript, suitable for handling binary data.

----

This guide provides an overview of the TypeScript language's capabilities, including supported versions and data type correspondence.
