---
title: GO
---

# GO

The Golang platform supports various project types using the Go programming language. It allows the creation of web services, command-line applications, desktop applications, libraries, and more.


## Supported Project Types

* `console`
* `library`


## Supported Languages

* `go`

## Platform Versions

* Go 1.12
* Go 1.13
* Go 1.14
* Go 1.15
* Go 1.16
* Go 1.17
* Go 1.18
* Go 1.19
* Go 1.20

## Runtime Versions

* Go 1.12
* Go 1.13
* Go 1.14
* Go 1.15
* Go 1.16
* Go 1.17
* Go 1.18
* Go 1.19
* Go 1.20


## Package Manager

* The Golang platform supports external packages through the Go Modules package manager. Support for additional package registries will be available in the future.



## Data Type Correspondence


## Data Type Correspondence

| Pars Data Type | Go Data Type       | Description                                              |
|----------------|--------------------|----------------------------------------------------------|
| Object         | interface{}        | The base type for all other types.                       |
| Bit            | bool               | Represents a binary digit, either 0 or 1.                |
| UInt8 (UByte)  | uint8              | Unsigned 8-bit integer.                                  |
| Int8 (Byte)    | int8               | Signed 8-bit integer.                                    |
| UInt16 (UShort)| uint16             | Unsigned 16-bit integer.                                 |
| Int16 (Short)  | int16              | Signed 16-bit integer.                                   |
| UInt32 (UInt)  | uint32             | Unsigned 32-bit integer.                                 |
| Int32 (Int)    | int32              | Signed 32-bit integer.                                   |
| UInt64 (ULong) | uint64             | Unsigned 64-bit integer.                                 |
| Int64 (Long)   | int64              | Signed 64-bit integer.                                   |
| UInt128        | uint64             | Unsigned 128-bit integer (represented by `uint64` in Go).|
| Int128         | int64              | Signed 128-bit integer (represented by `int64` in Go).   |
| Float16        | float32            | 16-bit floating-point number (represented by `float32` in Go). |
| Float32 (Float)| float32            | 32-bit floating-point number (single precision).         |
| Float64 (Double)| float64           | 64-bit floating-point number (double precision).         |
| Float128       | float64            | 128-bit floating-point number (represented by `float64` in Go). |
| Decimal        | float64            | Represents fixed-point numbers with specific decimal places. |
| String         | string             | Represents a sequence of characters.                     |
| Char           | rune               | Represents a single character.                           |
| Boolean        | bool               | Represents a logical value, either `true` or `false`.    |
| Blob           | []byte             | Represents a Binary Large Object.                        |
| Time           | time.Time          | Represents time-related data such as dates, times, or durations. |

**Notes:**

- Some types such as `UInt128`, `Int128`, `Float16`, and `Float128` do not have direct equivalents in Go. They are represented using the closest available types (`uint64`, `int64`, `float32`, and `float64`).
- `Blob` is represented as a `[]byte` in Go, suitable for handling binary data.



----

This guide provides an overview of the Golang platform's capabilities, including supported project types, languages, platform and runtime versions, and external package management through Go Modules. Future updates will include support for additional package registries





