---
title: C#
---

# C\#

## Overview

C# is a modern, object-oriented programming language developed by Microsoft. It is widely used for developing web applications, desktop applications, mobile applications, games, and more.

## Supported Versions

* C# 7.0
* C# 7.1
* C# 7.2
* C# 7.3
* C# 8.0
* C# 9.0
* C# 10.0
* C# 11.0

## Data Type Correspondence

| Pars Data Type | C# Data Type       | Description                                              |
|----------------|--------------------|----------------------------------------------------------|
| Object         | object             | The base type for all other types.                       |
| Bit            | bool               | Represents a binary digit, either 0 or 1.                |
| UInt8 (UByte)  | byte               | Unsigned 8-bit integer.                                  |
| Int8 (Byte)    | sbyte              | Signed 8-bit integer.                                    |
| UInt16 (UShort)| ushort             | Unsigned 16-bit integer.                                 |
| Int16 (Short)  | short              | Signed 16-bit integer.                                   |
| UInt32 (UInt)  | uint               | Unsigned 32-bit integer.                                 |
| Int32 (Int)    | int                | Signed 32-bit integer.                                   |
| UInt64 (ULong) | ulong              | Unsigned 64-bit integer.                                 |
| Int64 (Long)   | long               | Signed 64-bit integer.                                   |
| UInt128        | ulong              | Unsigned 128-bit integer (represented by `ulong` in C#). |
| Int128         | long               | Signed 128-bit integer (represented by `long` in C#).    |
| Float16        | float              | 16-bit floating-point number (represented by `float` in C#). |
| Float32 (Float)| float              | 32-bit floating-point number (single precision).         |
| Float64 (Double)| double            | 64-bit floating-point number (double precision).         |
| Float128       | double             | 128-bit floating-point number (represented by `double` in C#). |
| Decimal        | decimal            | Represents fixed-point numbers with specific decimal places. |
| String         | string             | Represents a sequence of characters.                     |
| Char           | char               | Represents a single character.                           |
| Boolean        | bool               | Represents a logical value, either `true` or `false`.    |
| Blob           | byte[]             | Represents a Binary Large Object.                        |
| Time           | DateTime           | Represents time-related data such as dates, times, or durations. |

**Notes:**

- Some types such as `UInt128`, `Int128`, `Float16`, and `Float128` do not have direct equivalents in C#. They are represented using the closest available types (`ulong`, `long`, and `double`).
- `Blob` is represented as a `byte[]` in C#, suitable for handling binary data.

----

This guide provides an overview of the C# language's capabilities, including supported versions and data type correspondence.
