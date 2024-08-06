---
title: Data Structures
---

# Data Structures

## Object
- **Description**: The base type for all other types. Every variable is of type `Object`, meaning any variable of any specific type is also an `Object`.
- **Symbol**: `{}`
- **Technical Details**: All types, including those defined under `Number`, `Text`, `Boolean`, `Map`, `Blob`, `Time`, and `Null`, are derived from `Object`.
- **Usage**: Used as a generic base class for all other types.
- **Example**: 
    ```pseudocode
    Object myObject = {};
    ```

## Collection
- **Description**: Groups of objects, such as arrays, lists, or sets.
- **Symbol**: `[]`
- **Technical Details**: Collections allow for the storage and manipulation of multiple items in a single structure.
- **Usage**: Used for storing and working with multiple items.
- **Example**: 
    ```pseudocode
    Int[] numbers = [1, 2, 3, 4, 5]
    ```



## Set
- **Description**: A collection of unique elements without duplicates.
- **Symbol**: `[,]`
- **Technical Details**: Sets ensure that each element is unique and provide efficient membership tests.
- **Usage**: Used for storing distinct elements and performing set operations like union, intersection, and difference.
- **Example**: 
    ```pseudocode
    Set[Int] uniqueNumbers = [1, 2, 3, 4, 5];
    ```

## Tuple
- **Description**: An ordered list of elements, which can be of different types. Tuples are typically used to group multiple values together and can be immutable, depending on the programming language.
- **Symbol**: `(,)`
- **Technical Details**: Tuples are indexed, starting from zero, and can hold a fixed number of elements. They are often used to return multiple values from a function or to group related data together.
- **Usage**: Used to store a collection of values of potentially different types. Commonly used in function return types and for grouping related values.
- **Example**: 
    ```pseudocode
    (String, Int) person = ("Alice", 30);
    ```


## Map
- **Description**: Key-value pairs, such as dictionaries or hash maps.
- **Symbol**: `{,}`
- **Technical Details**: Maps allow for the efficient retrieval of values based on keys.
- **Usage**: Used for associative arrays and similar structures where key-based access is needed.
- **Example**: 
    ```pseudocode
    Map[String, Int] ageMap = {"Alice": 30,  "Bob": 25}
    ```


## Enum
- **Description**: Enumerated type, representing a fixed set of named values.
- **Symbol**: `<>`
- **Technical Details**: Enums provide a way to define a set of named constants.
- **Usage**: Used for variables that can only take one out of a small set of possible values.
- **Example**: 
    ```pseudocode
    Enum Day {
        Monday,
        Tuesday,
        Wednesday,
        Thursday,
        Friday,
        Saturday,
        Sunday
    }
    ```