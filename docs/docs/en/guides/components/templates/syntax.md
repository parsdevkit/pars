---
title: Syntax
---


# Syntax

## Overview

Template Design provides a robust and flexible syntax for creating templates. This document outlines the fundamental components and structures used in template design, including functions, variables, objects, maps, arrays, conditions, loops, actions, delimiters, and comments.

## The basics

Templates are defined using a combination of static text and dynamic expressions. Dynamic expressions are enclosed within delimiters and can include variables, functions, pipelines, and more.


## Delimiters
Delimiters enclose dynamic expressions and commands within a template. `{{ }}` delimiters used for expressions and for statements.

```go
{{ expression }}
```


## Trim Markers
The hyphen trim marker is used to remove whitespace before or after a delimiter. It can be placed immediately inside a delimiter to trim spaces.


```go
{{- $variable }}  <!-- Trims space before the variable -->
{{ $variable -}}  <!-- Trims space after the variable -->
{{- $variable -}} <!-- Trims space before and after the variable -->
```

## Comments
Comments provide a way to include explanatory notes within a template. They are ignored during processing.

```go
{{/* This is a comment */}}
```



## Context
Context refers to the data available within a template. It includes variables, objects, and functions that can be referenced and manipulated. For more details visit [Context](./context.md)

In Pars templates, the dot (`.`) represents the current context, which is the data passed to the template. The context can be a simple variable, a complex object, or even a collection of objects. The dot is used to access fields and methods of the current context.


```go
{{ .Workspace.Name }}
```

**Context Scope**

The context (`.`) is scoped to the block it is in. For example, within a range or with block, the context changes to the specific item being iterated over or the specific part of the data structure being focused on.


```go
{{ range .workspace.projects }}
  {{ .title }} <!-- Within this block, . refers to each project -->
{{ end }}

{{ .workspace.name }} <!-- Outside the block, . refers to the root context -->
```

**Assigning Context to a Variable**

You can assign the current context to a variable for easier access or manipulation:

```go
{{ $context := .Workspace.Project }}
Project Title: {{ $context.Title }}
```

## Functions

Functions are predefined operations that can be used within templates to manipulate data, format output, and perform various tasks. For more details visit [Functions](./functions.md)

```go
{{ console.print "Hello World" }}
```

### Arguments

Functions can take arguments, which are values or expressions passed to the function. Arguments are enclosed in parentheses and separated by commas.

```go
{{ functionName arg1 arg2 }}
```

## Pipelines
Pipelines allow chaining of functions and operations, passing the output of one function as the input to the next. They are denoted by the `|` character.


```go
{{ variable | function1 | function2 }}
```


## Variables
Variables store values that can be referenced and manipulated within a template.


```go
{{ $variable := "value" }}
{{ $variable }}
```

**Variable scope**
Variables have a scope, which determines where they can be accessed within the template. Scope can be local (within a block) or global (across the entire template).

```go
{{ $global := "Global Scope" }}
{{ range $i, $item := .Items }}
  {{ $local := "Local Scope" }}
  {{ $global = "Modified Global" }}
  {{ $local = "Modified Local" }}
  {{ $i }}: {{ $item }}, Global: {{ $global }}, Local: {{ $local }}
{{ end }}
```

**Initial Assignment**

A variable is initially assigned a value using the `:=` operator. This creates a new variable and assigns it a value within the current scope.

```go
{{ $greeting := "Hello, World!" }}
{{ $greeting }}  <!-- Output: Hello, World! -->
```


**Re-assignment**

A variable can be re-assigned a new value using the `=` operator. This updates the existing variable's value within the current scope.

```go
{{ $greeting := "Hello, World!" }}
{{ $greeting = "Hi, Universe!" }}
{{ $greeting }}  <!-- Output: Hi, Universe! -->
```

## Objects
Objects represent structured data and can be accessed using dot notation.

```go
{{ .Object.Field }}
```

## Maps
Maps are collections of key-value pairs, where each key is unique.

```go
{{ $map := map.Dictionary "key1" "value1" "key2" "value2" }}
{{ $map.key1 }}
```

## Arrays
Arrays are ordered collections of elements, accessed by their index.

```go
{{ $array := array.Slice  "item1" "item2" "item3" }}
{{ index $array 0 }}
```

## Conditions
Conditions allow for branching logic within templates, enabling different outputs based on specified criteria.

```go
{{ if condition }}
  <!-- output if condition is true -->
{{ else if condition2 }}
  <!-- output if condition2 is true -->
{{ else }}
  <!-- output if condition is false -->
{{ end }}
```

## Range
Loops iterate over collections (arrays, maps, etc.), repeating a block of code for each element.

**Basic Syntax**
```go
{{ range $index, $element := $array }}
  {{ $index }}: {{ $element }}
{{ end }}
```

**Iterating Without Index**

If you do not need the index, you can iterate over the elements directly:

```go
{{ range $fruit := $fruits }}
  Fruit: {{ $fruit }}
{{ end }}
```

**Iterating Over an Array**

You can also iterate over an array without explicitly defining the variable:

```go
{{ range $fruits }}
  Fruit: {{ . }}
{{ end }}
```

**Using Else with Range**

The `else` action can be used to provide an alternative block of code to execute if the collection is empty.

```go
{{ range $fruits }}
  Fruit: {{ . }}
{{ else }}
  No fruits available.
{{ end }}
```

**Range with Maps**

When iterating over a map, `range` provides both the key and value.

```go
{{ $fruitColors := map.Dictionary "apple" "red" "banana" "yellow" "cherry" "red" }}
{{ range $fruit, $color := $fruitColors }}
  {{ $fruit }}: {{ $color }}
{{ end }}
```

### Break

The `break` action terminates the loop immediately and skips any remaining iterations.

```go
{{ range $index, $element := $collection }}
  {{ if condition }}
    {{ break }}
  {{ end }}
  <!-- actions -->
{{ end }}
```

### Continue

The `continue` action skips the current iteration and proceeds to the next one.

```go
{{ range $index, $element := $collection }}
  {{ if condition }}
    {{ continue }}
  {{ end }}
  <!-- actions -->
{{ end }}
```



## With

The `with` action in pars is used to specify a new context within a block. It allows you to drill down into a specific part of the data, making it easier to work with nested data structures by temporarily setting the context to a more specific value.


```go
{{ with <variable> }}
  <!-- ... if variable is not empty ... -->
{{ else }}
  <!-- ... if variable is empty ... -->
{{ end }}
```