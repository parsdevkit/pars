---
title: Functions
---

# Functions


## Engine




### engine.RenderContent 

**Description**

The `RenderContent` function takes a template name and data, then renders the content using the TemplateEngine.

**Signature**
```
RenderContent(templateName String, data Object) String

```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `templateName`| [`String`][String]| The name of the template to render.|
| `data`        | [`Object`][Object]   | The data to pass to the template. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The rendered content. Returns an empty string if an error occurs.    |



!!! example

    ```go
    {{ $context := GetContextByBase .BaseContext "Set::exampleSet" "Project::exampleProject" "Resource::exampleResource" }}
    {{ $templateName := "exampleTemplate" }}
    {{ $renderedContent := RenderContent $templateName $context }}
    Result: {{ $renderedContent }}
    ```
    <div class="result" sh>
    <pre>
    Result: Rendered content of template: exampleTemplate with data: { ...context data... }
    </pre>
    </div>

    In this example, the `RenderContent` method is utilized within the template to render content from a template named `exampleTemplate` using the context data obtained from `GetContextByBase`. The output shows the rendered content based on the provided template and data.







### engine.GetContent

**Description**

The `GetContent` method in the engine space retrieves the content of a shared template based on the specified template name. It uses the `SharedTemplateService` to fetch the template. If an error occurs or the template is not found, it returns an empty String.


**Signature**
```
GetContent(templateName String) string
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `templateName` | [`String`][String] | The name of the template to be retrieved.|


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The content of the specified template. Returns an empty string if any error occurs or the template is not found. |



!!! example

    ```go
    {{ $templateName := "exampleTemplate" }}
    {{ $templateContent := GetContent $templateName }}
    Content: {{ $templateContent }}
    ```
    <div class="result" sh>
    <pre>
    Content: The content of the template: exampleTemplate
    </pre>
    </div>

    In this example, the `GetContent` method is utilized within the template to retrieve the content of a template named `exampleTemplate`. The output shows the content of the specified template.






### engine.RenderTemplate

**Description**

The `RenderTemplate` method in the engine space renders a template using the specified template name and data. It retrieves the template content using the `GetContent` method and processes it with the `TemplateEngine` function. If an error occurs, it returns an empty string.


**Signature**
```
RenderTemplate(templateName string, data any) string
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `templateName` | [`String`][String] | The name of the template to be rendered. |
| `data`         | [`Object`][Object]    | The data to be used in the template.     |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The rendered content of the specified template with the provided data. Returns an empty string if any error occurs. |



!!! example

    ```go
    {{ $templateName := "exampleTemplate" }}
    {{ $data := .ExampleData }}
    {{ $renderedContent := RenderTemplate $templateName $data }}
    Content: {{ $renderedContent }}
    ```
    <div class="result" sh>
    <pre>
    Content: The rendered content of the template: exampleTemplate with provided data.
    </pre>
    </div>

    In this example, the `RenderTemplate` method is utilized within the template to render the content of a template named `exampleTemplate` with the provided data. The output shows the rendered content of the specified template.





























## Context



### context.GetContextByBase

**Description**

The `GetContextByBase` function retrieves a `TemplateDataContext` based on the provided base context and additional arguments. It resolves and validates various components like set, resource, layer, project, section, and template.


**Signature**
```
GetContextByBase(base Context, args ...String) Context
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `base`  | [`Context`][Context]     | The base context containing initial values.                    |
| `args`  | [`...String`][String]                | A variadic list of arguments to override or specify components in the context. Each argument should be in the format `Key::Value`. Valid keys include `Set`, `Project`, `Resource`, `Template`, `Layer`, and `Section`. |


**Return**

| Type | Description | 
|------|-------------|
| [`Context`][Context]     | The resolved context based on the provided base and additional arguments. Returns an empty [`Context`][Context] if any error occurs during the resolution process. |



!!! example

    ```go
    {{ $context := GetContextByBase .BaseContext "Set::exampleSet" "Project::exampleProject" "Resource::exampleResource" }}
    Result: {{ $context }}
    ```
    <div class="result" sh>
    <pre>
	Result: {Resolved context information based on provided arguments}
    </pre>
    </div>

    In this example, `GetContextByBase` returns a [`Context`][Context] with the specified set, project, and resource, resolved from the base context.







### context.GetContextByBaseForArray

**Description**

The `GetContextByBaseForArray` function retrieves a [`Context`][Context] based on the provided base context and additional arguments in an array format. It internally calls `GetContextByBase` to perform the resolution.


**Signature**
```
GetContextByBaseForArray(base Context, args []String) Context

```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `base`  | [`Context`][Context]     | The base context containing initial values.                    |
| `args`  | [`[]String`][String]     | An array of arguments to override or specify components in the context. Each argument should be in the format `key::value`. Valid keys include `Set`, `Project`, `Resource`, `Template`, `Layer`, and `Section`. |


**Return**

| Type | Description | 
|------|-------------|
| [`Context`][Context]     | The resolved context based on the provided base and additional arguments. Returns an empty [`Context`][Context] if any error occurs during the resolution process. |



!!! example

    ```go
    {{ $context := GetContextByBaseForArray .BaseContext (slice "Set::exampleSet" "Project::exampleProject" "Resource::exampleResource") }}
    Result: {{ $context }}
    ```
    <div class="result" sh>
    <pre>
	Result: {Resolved context information based on provided arguments}
    </pre>
    </div>

    In this example, `GetContextByBaseForArray` returns a `CodeTemplateDataContext` with the specified set, project, and resource, resolved from the base context.









## Logical Operators




### and

**Description**

The `and` function returns `true` if all provided boolean arguments are `true`. If any of the arguments is `false`, the function returns `false`.


**Signature**
```
and(args ...Boolean) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `args` | [`...Boolean`][Boolean] | A variadic list of boolean values to be evaluated. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean] | `true` if all arguments are `true`; otherwise, `false`. |



!!! example

    ```go
    {{ $result := and true true false }}
    Result: {{ $result }}
    ```
    <div class="result" sh>
    <pre>
	Result: false
    </pre>
    </div>

    In this example, `and` returns `false` because not all arguments are `true`.









### or

**Description**

The `or` function returns `true` if at least one of the provided boolean arguments is `true`. If all arguments are `false`, the function returns `false`.


**Signature**
```
or(args ...Boolean) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `args` | [`...Boolean`][Boolean] | A variadic list of boolean values to be evaluated. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean] | `true` if at least one argument is `true`; otherwise, `false`. |



!!! example

    ```go
    {{ $result := or false true false }}
    Result: {{ $result }}
    ```
    <div class="result" sh>
    <pre>
	Result: true
    </pre>
    </div>


    In this example, `or` returns `true` because at least one argument is `true`.










### not

**Description**

The `not` function returns the boolean negation of the provided argument. It returns `true` if the argument is `false`, and `false` if the argument is `true`.


**Signature**
```
not(arg Boolean) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `arg` | [`Boolean`][Boolean] | A variadic list of boolean values to be evaluated. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean] | `true` if at least one argument is `true`; otherwise, `false`. |



!!! example

    ```go
    {{ $result := not true }}
    Result: {{ $result }}
    ```
    <div class="result" sh>
    <pre>
	Result: false
    </pre>
    </div>


    In this example, `not` returns `false` because the argument is `true`.





## Comparison Operators


### eq

**Description**

The `eq` function returns the boolean truth of whether `arg1` is equal to `arg2`.


**Signature**
```
eq(arg1 Object, arg2 Object) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `arg1`  | [`Object`][Object] | The first number to compare. |
| `arg2`  | [`Object`][Object] | The second number to compare. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]  | `true` if `arg1` is equal to `arg2`; otherwise, `false`. |



!!! example

    ```go
    {{ $result := eq 5 5 }}
    Result: {{ $result }}
    ```
    <div class="result" sh>
    <pre>
	Result: true
    </pre>
    </div>

    In this example, `eq` returns `true` because `5` is equal to `5`.






### ne

**Description**

The `ne` function returns the boolean truth of whether `arg1` is not equal to `arg2`.


**Signature**
```
ne(arg1 Object, arg2 Object) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `arg1`  | [`Object`][Object] | The first number to compare. |
| `arg2`  | [`Object`][Object] | The second number to compare. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]  | `true` if `arg1` is not equal to `arg2`; otherwise, `false`. |



!!! example

    ```go
    {{ $result := ne 5 3 }}
    Result: {{ $result }}
    ```
    <div class="result" sh>
    <pre>
	Result: true
    </pre>
    </div>

    In this example, `ne` returns `true` because `5` is not equal to `3`.









### lt

**Description**

The `lt` function returns the boolean truth of whether `arg1` is less than `arg2`.


**Signature**
```
lt(arg1 Number, arg2 Number) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `arg1`  | [`Number`][Number] | The first number to compare. |
| `arg2`  | [`Number`][Number] | The second number to compare. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]  | `true` if `arg1` is less than `arg2`; otherwise, `false`. |



!!! example

    ```go
    {{ $result := ne 3 5 }}
    Result: {{ $result }}
    ```
    <div class="result" sh>
    <pre>
	Result: true
    </pre>
    </div>

    In this example, `lt` returns `true` because `3` is less than `5`.















### le

**Description**

The `le` function returns the boolean truth of whether `arg1` is less than or equal `arg2`.


**Signature**
```
le(arg1 Number, arg2 Number) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `arg1`  | [`Number`][Number] | The first number to compare. |
| `arg2`  | [`Number`][Number] | The second number to compare. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]  | `true` if `arg1` is less than or equal to `arg2`; otherwise, `false`. |



!!! example

    ```go
    {{ $result := le 5 5 }}
    Result: {{ $result }}
    ```
    <div class="result" sh>
    <pre>
	Result: true
    </pre>
    </div>

    In this example, `le` returns `true` because `5` is less than or equal to `5`.












### gt

**Description**

The `gt` function returns the boolean truth of whether `arg1` is greater than `arg2`.


**Signature**
```
gt(arg1 Number, arg2 Number) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `arg1`  | [`Number`][Number] | The first number to compare. |
| `arg2`  | [`Number`][Number] | The second number to compare. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]  | `true` if `arg1` is greater than `arg2`; otherwise, `false`. |



!!! example

    ```go
    {{ $result := gt 7 5 }}
    Result: {{ $result }}
    ```
    <div class="result" sh>
    <pre>
	Result: true
    </pre>
    </div>

    In this example, `gt` returns `true` because `5` is greater than `3`.















### ge

**Description**

The `ge` function returns the boolean truth of whether `arg1` is greater than or equal `arg2`.


**Signature**
```
ge(arg1 Number, arg2 Number) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `arg1`  | [`Number`][Number] | The first number to compare. |
| `arg2`  | [`Number`][Number] | The second number to compare. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]  | `true` if `arg1` is greater than or equal to `arg2`; otherwise, `false`. |



!!! example

    ```go
    {{ $result := ge 5 5 }}
    Result: {{ $result }}
    ```
    <div class="result" sh>
    <pre>
	Result: true
    </pre>
    </div>

    In this example, `gt` returns `true` because `5` is greater than or equal to `5`.







## Math

### math.Abs
**Description**
The `Abs` method in the math space calculates the absolute value of a number. It takes one [`Number`][Number] parameter, and returns the result as a [`Float64`][Float64].

**Signature**
```
Abs(x Number) Float64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`x`|[`Number`][Number]|The number to find the absolute value of|



**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64]|The absolute value of `x` |



!!! example

    ```go
    {{ $number := -3.5 }}
    The absolute value of {{ $number }} is {{ math.Abs $number }}
    ```
    <div class="result" sh>
    <pre>
    The absolute value of -3.5 is 3.5
    </pre>
    </div>

    In this example, the `Abs` method is utilized within the template to compute the absolute value of -3.5, resulting in the output `The absolute value of -3.5 is 3.5`.


### math.Add
**Description**
The `Add` method in the math space calculates the sum of multiple numbers. It takes a variadic number of [`Number`][Number] parameters, and returns the result as a [`Float64`][Float64].



**Signature**
```
Add(values ...Number) Float64
```

**Parameters**

| Name   | Type      | Description                    |
|--------|-----------|--------------------------------|
|`values`|[`...Number`][Number]|A variadic number of values to be summed|


**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64] | The sum of the values    |



!!! example

    ```go
    {{ $values := list 1 2 3 4.5 }}
    The sum of the values is {{ math.Add $values... }}
    ```
    <div class="result" sh>
    <pre>
    The sum of the values is 10.5
    </pre>
    </div>

    In this example, the `Add` method is utilized within the template to compute the sum of the values 1, 2, 3, and 4.5, resulting in the output `The sum of the values is 10.5`.








### math.Sub 
**Description**
The `Sub` method in the math space calculates the difference between two numbers. It takes two [`Number`][Number] parameters, and returns the result as a [`Float64`][Float64].



**Signature**
```
Sub(Number x, Number y) Float64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`x`   |[`Number`][Number] | The number to be subtracted from |
|`y`   |[`Number`][Number] | The number to subtract           |



**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64] | The difference between `x` and `y` |



!!! example

    ```go
    {{ $minuend := 10 }}
    {{ $subtrahend := 3 }}
    The difference between {{ $minuend }} and {{ $subtrahend }} is {{ math.Sub $minuend $subtrahend }}

    ```
    <div class="result" sh>
    <pre>
    The difference between 10 and 3 is 7
    </pre>
    </div>

    In this example, the `Sub` method is utilized within the template to compute the difference between 10 and 3, resulting in the output `The difference between 10 and 3 is 7`.





### math.Pow
**Description**
The `Pow` method in the `math` space calculates the power of one number raised to another. It takes two [`Number`][Number] parameters, and returns the result as a [`Float64`][Float64].

**Signature**
```
Pow(Number x, Number y) Float64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`x`|[`Number`][Number]|The base number|
|`y`|[`Number`][Number]|The exponent|



**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64]|The result of raising `x` to the power of `y`|



!!! example

    ```go
    {{ $base := 2 }}
    {{ $exponent := 3 }}
    The result of {{ $base }}^{{ $exponent }} is {{ math.Pow $base $exponent }}
    ```
    <div class="result" sh>
    <pre>
    The result of 2^3 is 8
    </pre>
    </div>

    In this example, the `Pow` method is utilized within the template to compute the power of 2 raised to 3, resulting in the output `The result of 2^3 is 8`.





### math.Mul
**Description**
The `Mul` method in the `math` space calculates the product of multiple numbers. It takes a variadic number of [`Number`][Number] parameters, and returns the result as a [`Float64`][Float64].


**Signature**
```
Mul(values ...Number) Float64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`values`|[`...Number`][Number]|A variadic number of values to be multiplied|



**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64] | The product of the values  |



!!! example

    ```go
    {{ $values := list 1 2 3 4.5 }}
    The product of the values is {{ math.Mul $values... }}
    ```
    <div class="result" sh>
    <pre>
    The product of the values is 27
    </pre>
    </div>

    In this example, the `Mul` method is utilized within the template to compute the product of the values 1, 2, 3, and 4.5, resulting in the output `The product of the values is 27`.



### math.Div
**Description**
The `Div` method in the `math` space calculates the division of one number by another. It takes two [`Number`][Number] parameters, and returns the result as a [`Float64`][Float64]. If the second parameter is zero, it panics with the message "division by zero".




**Signature**
```
Div(Number x, Number y) Float64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`x`   |[`Number`][Number] | The dividend                 |
|`y`   |[`Number`][Number] | The divisor                  |



**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64] | The result of the division |



!!! example

    ```go
    {{ $dividend := 10 }}
    {{ $divisor := 2 }}
    The result of dividing {{ $dividend }} by {{ $divisor }} is {{ math.Div $dividend $divisor }}

    ```
    <div class="result" sh>
    <pre>
    The result of dividing 10 by 2 is 5
    </pre>
    </div>

    In this example, the `Div` method is utilized within the template to compute the division of 10 by 2, resulting in the output `The result of dividing 10 by 2 is 5`.






### math.Max 
**Description**
The `Max` method in the `math` space returns the maximum of two numbers. It takes two [`Number`][Number] parameters, and returns the result as a [`Float64`][Float64].




**Signature**
```
Max(Number x, Number y) Float64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`x`   |[`Number`][Number] | The first number   |
|`y`   |[`Number`][Number] | The second number  |



**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64] | The maximum of \`x\` and \`y\`  |



!!! example

    ```go
    {{ $a := 5 }}
    {{ $b := 10 }}
    The maximum of {{ $a }} and {{ $b }} is {{ math.Max $a $b }}

    ```
    <div class="result" sh>
    <pre>
    The maximum of 5 and 10 is 10

    </pre>
    </div>

    In this example, the `Max` method is utilized within the template to find the maximum of 5 and 10, resulting in the output `The maximum of 5 and 10 is 10`.








### math.Min 
**Description**
The `Min` method in the `math` space returns the minimum of two numbers. It takes two [`Number`][Number] parameters, and returns the result as a [`Float64`][Float64].






**Signature**
```
Min(Number x, Number y) Float64

```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`x`   |[`Number`][Number] | The first number   |
|`y`   |[`Number`][Number] | The second number  |



**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64] | The minimum of \`x\` and \`y\`  |



!!! example

    ```go
    {{ $a := 5 }}
    {{ $b := 10 }}
    The minimum of {{ $a }} and {{ $b }} is {{ math.Min $a $b }}

    ```
    <div class="result" sh>
    <pre>
    The minimum of 5 and 10 is 5
    </pre>
    </div>

    In this example, the `Min` method is utilized within the template to find the minimum of 5 and 10, resulting in the output `The minimum of 5 and 10 is 5`.









### math.Mod 
**Description**
The `Mod` method in the `math` space calculates the modulus of one number by another. It takes two [`Number`][Number] parameters, and returns the result as a [`Float64`][Float64].



**Signature**
```
Mod(Number x, Number y) Float64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`x`   |[`Number`][Number] | The dividend           |
|`y`   |[`Number`][Number] | The divisor            |



**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64] | The modulus of \`x\` by \`y\`   |



!!! example

    ```go
    {{ $a := 10 }}
    {{ $b := 3 }}
    The modulus of {{ $a }} by {{ $b }} is {{ math.Mod $a $b }}
    ```
    <div class="result" sh>
    <pre>
    The modulus of 10 by 3 is 1

    </pre>
    </div>

    In this example, the `Mod` method is utilized within the template to compute the modulus of 10 by 3, resulting in the output `The modulus of 10 by 3 is 1`.









### math.Round 
**Description**
The `Round` method in the `math` space rounds a number to the nearest integer. It takes one [`Number`][Number] parameter, converts it to [`Float64`][Float64] if valid, and returns the result as a [`Float64`][Float64].

**Signature**
```
Round(Number x) Float64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`x`   |[`Number`][Number] | The number to round|



**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64] | The rounded value of \`x\`      |



!!! example

    ```go
    {{ $a := 3.6 }}
    The rounded value of {{ $a }} is {{ math.Round $a }}

    ```
    <div class="result" sh>
    <pre>
    The rounded value of 3.6 is 4


    </pre>
    </div>

    In this example, the `Round` method is utilized within the template to round the number 3.6, resulting in the output `The rounded value of 3.6 is 4`.









### math.Floor 
**Description**
The `Floor` method in the `math` space returns the largest integer less than or equal to a given number. It takes one [`Number`][Number] parameter, converts it to [`Float64`][Float64] if valid, and returns the result as a [`Float64`][Float64].



**Signature**
```
Floor(Number x) Float64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`x`   |[`Number`][Number] | The number to floor    |



**Return**

| Type | Description | 
|------|-------------|
|[`Float64`][Float64] | The floored value of \`x\`      |



!!! example

    ```go
    {{ $a := 3.6 }}
    The floored value of {{ $a }} is {{ math.Floor $a }}
    ```
    <div class="result" sh>
    <pre>
    The floored value of 3.6 is 3

    </pre>
    </div>

    In this example, the `Floor` method is utilized within the template to floor the number 3.6, resulting in the output `The floored value of 3.6 is 3`.







### math.IsInt 
**Description**
The `IsInt` method in the `math` space checks if a given value is an integer. It takes one [`Object`][Object] parameter and returns `true` if the value is an integer or a string representing an integer, otherwise returns `false`.



**Signature**
```
IsInt(Object n) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`n`   |[`Object`][Object] | The value to be checked         |



**Return**

| Type | Description | 
|------|-------------|
|[`Boolean`][Boolean] | \`true\` if \`n\` is an integer, else \`false\` |



!!! example

    ```go
    {{ $val := 123 }}
    Is {{ $val }} an integer? {{ math.IsInt $val }}

    ```
    <div class="result" sh>
    <pre>
    Is 123 an integer? true
    </pre>
    </div>

    In this example, the `IsInt` method is utilized within the template to check if 123 is an integer, resulting in the output `Is 123 an integer? true`.








### math.IsFloat
**Description**
The `IsFloat` method in the `math` space checks if a given value is a floating-point number. It takes one [`Object`][Object] parameter and returns `true` if the value is a float or a string representing a float, otherwise returns `false`.




**Signature**
```
IsFloat(Object n) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`n`   |[`Object`][Object] | The value to be checked         |



**Return**

| Type | Description | 
|------|-------------|
|[`Boolean`][Boolean] | \`true\` if \`n\` is a float, else \`false\` |



!!! example

    ```go
    {{ $val := "123.45" }}
    Is {{ $val }} a float? {{ math.IsFloat $val }}
    ```
    <div class="result" sh>
    <pre>
    Is 123.45 a float? true
    </pre>
    </div>

    In this example, the `IsFloat` method is utilized within the template to check if "123.45" is a float, resulting in the output `Is 123.45 a float? true`.




    



### math.IsNum
**Description**
The `IsNum` method in the `math` space checks if a given value is a number (either an integer or a float). It takes one [`Object`][Object] parameter and returns `true` if the value is a number or a string representing a number, otherwise returns `false`.

**Signature**
```
IsNum(Object n) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`n`   |[`Object`][Object] | The value to be checked         |



**Return**

| Type | Description | 
|------|-------------|
|[`Boolean`][Boolean] | \`true\` if \`n\` is a number, else \`false\` |



!!! example

    ```go
    {{ $val := "123.45" }}
    Is {{ $val }} a number? {{ math.IsNum $val }}
    ```
    <div class="result" sh>
    <pre>
    Is 123.45 a number? true
    </pre>
    </div>

    In this example, the `IsNum` method is utilized within the template to check if "123.45" is a number, resulting in the output `Is 123.45 a number? true`.


## String



### string.StartsWith

**Description**

The `StartsWith` method checks if the given string starts with the specified prefix.


**Signature**
```
StartsWith(str String, prefix String) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to check the prefix against.      |
| `prefix`   |[`String`][String] | The prefix to check at the start of the string. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean] | `true` if the string starts with the prefix, `false` otherwise. |



!!! example

    ```go
    {{ $str := "Hello, world!" }}
    {{ $prefix := "Hello" }}
    Starts with prefix: {{ string.StartsWith $str $prefix }}
    ```
    <div class="result" sh>
    <pre>
	Starts with prefix: true
    </pre>
    </div>

    In this example, the `StartsWith` method is utilized within the template to check if `"Hello, world!"` starts with `"Hello"`, resulting in the output `Starts with prefix: true`.









### string.EndsWith

**Description**

The `EndsWith` method checks if the given string ends with the specified suffix.


**Signature**
```
EndsWith(str String, suffix String) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to check the suffix against.      |
| `suffix`   | [`String`][String] | The suffix to check at the end of the string. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean] | `true` if the string ends with the suffix, `false` otherwise. |



!!! example

    ```go
    {{ $str := "Hello, world!" }}
    {{ $suffix := "world!" }}
    Ends with suffix: {{ string.EndsWith $str $suffix }}
    ```
    <div class="result" sh>
    <pre>
	Ends with suffix: true
    </pre>
    </div>

    In this example, the `EndsWith` method is utilized within the template to check if `"Hello, world!"` ends with `"world!"`, resulting in the output `Ends with suffix: true`.








### string.Contains

**Description**

The `Contains` method checks if the given string contains the specified substring.


**Signature**
```
Contains(str String, substr String) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to search within.                 |
| `substr`   | [`String`][String] | The substring to search for within the string. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]` | `true` if the string contains the substring, `false` otherwise. |



!!! example

    ```go
    {{ $str := "Hello, world!" }}
    {{ $substr := "world" }}
    Contains substring: {{ string.Contains $str $substr }}
    ```
    <div class="result" sh>
    <pre>
	Contains substring: true
    </pre>
    </div>


    In this example, the `Contains` method is utilized within the template to check if `"Hello, world!"` contains `"world"`, resulting in the output `Contains substring: true`.





### string.ToUpperCase

**Description**

The `ToUpperCase` method converts all characters in the given string to uppercase.


**Signature**
```
ToUpperCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to uppercase. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The uppercase version of the input string. |



!!! example

    ```go
    {{ $str := "Hello, world!" }}
    Uppercase: {{ string.ToUpperCase $str }}
    ```
    <div class="result" sh>
    <pre>
	Uppercase: HELLO, WORLD!
    </pre>
    </div>

    In this example, the `ToUpperCase` method is utilized within the template to convert `"Hello, world!"` to uppercase, resulting in the output `Uppercase: HELLO, WORLD!`.





### string.ToLowerCase

**Description**

The `ToLowerCase` method converts all characters in the given string to lowercase.


**Signature**
```
ToLowerCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to lowercase. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The lowercase version of the input string. |



!!! example

    ```go
    {{ $str := "Hello, world!" }}
    Lowercase: {{ string.ToLowerCase $str }}
    ```
    <div class="result" sh>
    <pre>
	Lowercase: hello, world!
    </pre>
    </div>


    In this example, the `ToLowerCase` method is utilized within the template to convert `"Hello, world!"` to lowercase, resulting in the output `Lowercase: hello, world!`.





### string.ToPascalCase

**Description**

The `ToPascalCase` method converts the given string to PascalCase format, where each word starts with an uppercase letter and there are no spaces between words.


**Signature**
```
ToPascalCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to PascalCase. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The PascalCase version of the input string. |



!!! example

    ```go
    {{ $str := "hello world example" }}
    PascalCase: {{ string.ToPascalCase $str }}
    ```
    <div class="result" sh>
    <pre>
	PascalCase: HelloWorldExample
    </pre>
    </div>

    In this example, the `ToPascalCase` method is utilized within the template to convert `"hello world example"` to PascalCase, resulting in the output `PascalCase: HelloWorldExample`.





### string.ToCamelCase

**Description**

The `ToCamelCase` method converts the given string to camelCase format, where the first word is in lowercase and subsequent words start with uppercase letters, with no spaces between words.


**Signature**
```
ToCamelCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to camelCase. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The camelCase version of the input string. |



!!! example

    ```go
    {{ $str := "hello world example" }}
    CamelCase: {{ string.ToCamelCase $str }}
    ```
    <div class="result" sh>
    <pre>
	CamelCase: helloWorldExample
    </pre>
    </div>

    In this example, the `ToCamelCase` method is utilized within the template to convert `"hello world example"` to camelCase, resulting in the output `CamelCase: helloWorldExample`.





### string.ToSnakeCase

**Description**

The `ToSnakeCase` method converts the given [`String`][String] to snake_case format, where words are separated by underscores, and all letters are in lowercase.


**Signature**
```
ToSnakeCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to snake_case. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The snake_case version of the input string. |



!!! example

    ```go
    {{ $str := "HelloWorldExample" }}
    SnakeCase: {{ string.ToSnakeCase $str }}
    ```
    <div class="result" sh>
    <pre>
	SnakeCase: hello_world_example
    </pre>
    </div>


    In this example, the `ToSnakeCase` method is utilized within the template to convert `"HelloWorldExample"` to snake_case, resulting in the output `SnakeCase: hello_world_example`.




### string.ToKebabCase

**Description**

The `ToKebabCase` method converts the given string to kebab-case format, where words are separated by hyphens, and all letters are in lowercase.


**Signature**
```
ToKebabCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to kebab-case. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The kebab-case version of the input string. |



!!! example

    ```go
    {{ $str := "Hello World Example" }}
    KebabCase: {{ string.ToKebabCase $str }}
    ```
    <div class="result" sh>
    <pre>
	KebabCase: hello-world-example
    </pre>
    </div>

    In this example, the `ToKebabCase` method is utilized within the template to convert `"Hello World Example"` to kebab-case, resulting in the output `KebabCase: hello-world-example`.





### string.ToUpperFlatCase

**Description**

The `ToUpperFlatCase` method converts the given string to flat case format, where all spaces are removed, and all letters are converted to uppercase.


**Signature**
```
ToUpperFlatCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to flat case. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The uppercase flat case version of the input string. |



!!! example

    ```go
    {{ $str := "Hello World Example" }}
    UpperFlatCase: {{ string.ToUpperFlatCase $str }}
    ```
    <div class="result" sh>
    <pre>
	UpperFlatCase: HELLOWORLDEXAMPLE
    </pre>
    </div>

    In this example, the `ToUpperFlatCase` method is utilized within the template to convert `"Hello World Example"` to flat case with uppercase letters, resulting in the output `UpperFlatCase: HELLOWORLDEXAMPLE`.





### string.ToLowerFlatCase

**Description**

The `ToLowerFlatCase` method converts the given string to flat case format, where all spaces are removed, and all letters are converted to lowercase.


**Signature**
```
ToLowerFlatCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to flat case. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The lowercase flat case version of the input string. |



!!! example

    ```go
    {{ $str := "Hello World Example" }}
    LowerFlatCase: {{ string.ToLowerFlatCase $str }}
    ```
    <div class="result" sh>
    <pre>
	LowerFlatCase: helloworldexample
    </pre>
    </div>

    In this example, the `ToLowerFlatCase` method is utilized within the template to convert `"Hello World Example"` to flat case with lowercase letters, resulting in the output `LowerFlatCase: helloworldexample`.





### string.ToCobolCase

**Description**

The ToCobolCase method converts the given string to COBOL case format, where spaces are replaced by hyphens, and all letters are converted to uppercase.


**Signature**
```
ToCobolCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to COBOL case. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The COBOL case version of the input string. |



!!! example

    ```go
    {{ $str := "Hello World Example" }}
    CobolCase: {{ string.ToCobolCase $str }}
    ```
    <div class="result" sh>
    <pre>
	CobolCase: HELLO-WORLD-EXAMPLE
    </pre>
    </div>

    In this example, the `ToCobolCase` method is utilized within the template to convert `"Hello World Example"` to COBOL case, resulting in the output `CobolCase: HELLO-WORLD-EXAMPLE`.





### string.ToTrainCase

**Description**

The `ToTrainCase` method converts the given string to Train Case format, where words are capitalized, separated by hyphens, and spaces are replaced with hyphens.


**Signature**
```
ToTrainCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to Train Case. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The Train Case version of the input string. |



!!! example

    ```go
    {{ $str := "hello world example" }}
    TrainCase: {{ string.ToTrainCase $str }}
    ```
    <div class="result" sh>
    <pre>
	TrainCase: Hello-World-Example
    </pre>
    </div>


    In this example, the `ToTrainCase` method is utilized within the template to convert `"hello world example"` to Train Case, resulting in the output `TrainCase: Hello-World-Example`.





### string.ToNormalCase


**Description**

The `ToNormalCase` method converts the given string to a more natural format, where hyphens and underscores are replaced by spaces, and each word is capitalized.


**Signature**
```
ToNormalCase(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`      | [`String`][String] | The string to convert to Normal Case. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The Normal Case version of the input string. |



!!! example

    ```go
    {{ $str := "hello-world_example" }}
    NormalCase: {{ string.ToNormalCase $str }}
    ```
    <div class="result" sh>
    <pre>
	NormalCase: Hello World Example
    </pre>
    </div>

    In this example, the `ToNormalCase` method is utilized within the template to convert `"hello-world_example"` to a normal case format, resulting in the output `NormalCase: Hello World Example`.





### string.Normalize

**Description**

The `Normalize` method replaces newline characters with spaces and trims leading and trailing spaces from the given string.

**Signature**
```
Normalize(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`  | [`String`][String] | The string to normalize by replacing newlines with spaces and trimming. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The normalized string with newlines replaced by spaces and trimmed. |



!!! example

    ```go
    {{ $str := "  Hello\nWorld  " }}
    Normalized: {{ string.Normalize $str }}
    ```
    <div class="result" sh>
    <pre>
	Normalized: Hello World
    </pre>
    </div>


    In this example, the `Normalize` method is utilized within the template to replace newline characters in `" Hello\nWorld "` with spaces and trim the result, resulting in the output `Normalized: Hello World`.




### string.TrimSpace

**Description**

The `TrimSpace` method removes leading and trailing white space characters from the given string.


**Signature**
```
TrimSpace(str String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`  | [`String`][String] | The string from which leading and trailing white spaces are to be removed. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The string with leading and trailing white spaces removed. |



!!! example

    ```go
    {{ $str := "  Hello World  " }}
    Trimmed: {{ string.TrimSpace $str }}
    ```
    <div class="result" sh>
    <pre>
	Trimmed: Hello World
    </pre>
    </div>


    In this example, the `TrimSpace` method is utilized within the template to remove leading and trailing spaces from `" Hello World "`, resulting in the output `Trimmed: Hello World`.





### string.Trim

**Description**

The `Trim` method removes all leading and trailing occurrences of the specified cutset characters from the given string.


**Signature**
```
Trim(str String, cutset String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`    | [`String`][String] | The string to trim.                            |
| `cutset` | [`String`][String] | The set of characters to remove from the start and end of `str`. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The string with specified characters removed from the start and end. |



!!! example

    ```go
    {{ $str := "***Hello World***" }}
    Trimmed: {{ string.Trim $str "*" }}
    ```
    <div class="result" sh>
    <pre>
	Trimmed: Hello World
    </pre>
    </div>

    In this example, the `Trim` method is utilized within the template to remove asterisks from both ends of `"***Hello World***"`, resulting in the output `Trimmed: Hello World`.




### string.TrimSuffix

**Description**

The `TrimSuffix` method removes the specified suffix characters from the end of the given string.


**Signature**
```
TrimSuffix(str String, cutset String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`    | [`String`][String] | The string from which to remove the suffix. |
| `cutset` | [`String`][String] | The suffix characters to remove from `str`. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The string with the specified suffix removed. |



!!! example

    ```go
    {{ $str := "Hello World!!!" }}
    Trimmed: {{ string.TrimSuffix $str "!" }}
    ```
    <div class="result" sh>
    <pre>
	Trimmed: Hello World
    </pre>
    </div>


    In this example, the `TrimSuffix` method is utilized within the template to remove exclamation marks from the end of `"Hello World!!!"`, resulting in the output `Trimmed: Hello World`.





### string.TrimPrefix

**Description**

The `TrimPrefix` method removes the specified prefix characters from the start of the given string.


**Signature**
```
TrimPrefix(str String, cutset String) string
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str`    | [`String`][String] | The string from which to remove the prefix. |
| `cutset` | [`String`][String] | The prefix characters to remove from `str`. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The string with the specified prefix removed. |



!!! example

    ```go
    {{ $str := "!!!Hello World" }}
    Trimmed: {{ string.TrimPrefix $str "!" }}
    ```
    <div class="result" sh>
    <pre>
	Trimmed: Hello World
    </pre>
    </div>

    In this example, the `TrimPrefix` method is utilized within the template to remove exclamation marks from the start of `"!!!Hello World"`, resulting in the output `Trimmed: Hello World`.







### string.Replace

**Description**

The `Replace` method replaces occurrences of the old substring with the new substring in the given string, up to a specified number of replacements.


**Signature**
```
Replace(str String, old String, new String, n Int) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str` | [`String`][String] | The string in which replacements are to be made. |
| `old` | [`String`][String] | The substring to be replaced.                 |
| `new` | [`String`][String] | The substring to replace `old` with.         |
| `n`   | [`Int`][Int]    | The maximum number of replacements. Use `-1` to replace all occurrences. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The string with `old` replaced by `new` up to `n` times. |



!!! example

    ```go
    {{ $str := "foo foo foo" }}
    Replaced: {{ string.Replace $str "foo" "bar" 2 }}
    ```
    <div class="result" sh>
    <pre>
	Replaced: bar bar foo
    </pre>
    </div>

    In this example, the `Replace` method is utilized within the template to replace the first two occurrences of `"foo"` with `"bar"` in `"foo foo foo"`, resulting in the output `Replaced: bar bar foo`.




### string.Split

**Description**

The `Split` method splits the given string into a slice of substrings separated by the specified separator.


**Signature**
```
Split(str String, sep String) []String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str` | [`String`][String] | The string to split.                      |
| `sep` | [`String`][String] | The separator to use for splitting.       |


**Return**

| Type | Description | 
|------|-------------|
| [`...String`][String] | A slice of substrings split by `sep`. |



!!! example

    ```go
    {{ $str := "a,b,c" }}
    Split: {{ string.Split $str "," }}
    ```
    <div class="result" sh>
    <pre>
	Split: [a b c]
    </pre>
    </div>

    In this example, the `Split` method is utilized within the template to split `"a,b,c"` by commas, resulting in the output `Split: [a b c]`.





### string.Concat

**Description**

The `Concat` method concatenates a slice of strings into a single string, separated by the specified separator.


**Signature**
```
Concat(sep String, items ...String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `sep` | [`String`][String]     | The separator to insert between items. |
| `items` | [`...String`][String] | The strings to concatenate.            |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The concatenated string with `sep` between items. |



!!! example

    ```go
    {{ $items := list "a" "b" "c" }}
    Concatenated: {{ string.Concat "," $items }}
    ```
    <div class="result" sh>
    <pre>
	Concatenated: a,b,c
    </pre>
    </div>

    In this example, the `Concat` method is utilized within the template to concatenate `"a"`, `"b"`, and `"c"` with commas, resulting in the output `Concatenated: a,b,c`.





### string.Repeat

**Description**

The `Repeat` method repeats the given string a specified number of times.


**Signature**
```
Repeat(str String, count Int) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `str` | [`String`][String] | The string to repeat.              |
| `count` | [`Int`][Int]   | The number of times to repeat the string. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The string repeated `count` times.       |



!!! example

    ```go
    {{ $str := "Pars" }}
    Repeated: {{ string.Repeat $str 3 }}
    ```
    <div class="result" sh>
    <pre>
	Repeated: ParsParsPars
    </pre>
    </div>

    In this example, the `Repeat` method is utilized within the template to repeat `"Pars"` three times, resulting in the output `Repeated: ParsParsPars`.






### string.JoinFields

**Description**

The `JoinFields` method joins the fields of a slice of structs or simple values into a single string, separated by the specified separator. If the slice contains structs, it extracts the value of the specified field.

**Signature**
```
JoinFields(slice []Object, sep String, key String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `slice` | [`[]Object`][Object] | The slice containing structs or simple values.     |
| `sep`   | [`String`][String]   | The separator to insert between joined fields.     |
| `key`   | [`String`][String]   | The field name to extract from structs (ignored if `slice` contains simple values). |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The joined string with fields separated by `sep`. |



!!! example

    ```go
    {{ $items := list (struct "Name" "Alice") (struct "Name" "Bob") }}
    Joined Fields: {{ string.JoinFields $items "," "Name" }}
    ```
    <div class="result" sh>
    <pre>
	Joined Fields: Alice,Bob
    </pre>
    </div>

    In this example, the `JoinFields` method is utilized within the template to join the `"Name"` fields from a slice of structs with commas, resulting in the output `Joined Fields: Alice,Bob`.






### string.SplitFields

**Description**

The `SplitFields` method splits the given string into a slice of interfaces using the specified separator.


**Signature**
```
SplitFields(input String, sep String) []String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `input` | [`String`][String] | The string to split.                     |
| `sep`   | [`String`][String] | The separator to use for splitting.      |


**Return**

| Type | Description | 
|------|-------------|
| [`[]String`][Object] | A slice of split substrings as interfaces. |



!!! example

    ```go
    {{ $input := "a,b,c" }}
    Split Fields: {{ string.SplitFields $input "," }}
    ```
    <div class="result" sh>
    <pre>
	Split Fields: [a b c]
    </pre>
    </div>

    In this example, the `SplitFields` method is utilized within the template to split` "a,b,c"` by commas, resulting in the output `Split Fields: [a b c]`.









### string.Pluralize <!-- md:flag experimental -->

**Description**

The `Pluralize` method returns the plural form of the given word. It handles irregular plurals and applies common English pluralization rules.

**Signature**
```
Pluralize(word String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `word` | [`String`][String] | The singular word to pluralize.   |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The plural form of the given word.          |



!!! example

    ```go
    {{ $word := "child" }}
    Pluralized: {{ string.Pluralize $word }}
    ```
    <div class="result" sh>
    <pre>
	Pluralized: children
    </pre>
    </div>


    In this example, the `Pluralize` method is utilized within the template to convert `"child"` to its plural form `"children"`, resulting in the output `Pluralized: children`.







### string.UnPluralize <!-- md:flag experimental -->

**Description**

The `UnPluralize` method returns the singular form of the given plural word. It handles irregular plurals and applies common English singularization rules.


**Signature**
```
UnPluralize(word String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `word` | [`String`][String] | The plural word to singularize.      |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The singular form of the given plural word. |



!!! example

    ```go
    {{ $word := "children" }}
    Singularized: {{ string.UnPluralize $word }}
    ```
    <div class="result" sh>
    <pre>
	Singularized: child
    </pre>
    </div>

    In this example, the `UnPluralize` method is utilized within the template to convert `"children"` to its singular form `"child"`, resulting in the output `Singularized: child`.







### string.Indent

**Description**

The `Indent` method adds a specified indentation to the beginning of each line in the given text. It preserves the existing content of the lines and adds the indentation before each line.


**Signature**
```
Indent(text String, indent String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `text` | [`String`][String] | The text to which indentation will be added. |
| `indent` | [`String`][String] | The indentation to add before each line.     |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The text with added indentation.             |



!!! example

    ```go
    {{ $text := "line1\nline2" }}
    {{ $indent := "    " }}
    Indented: {{ string.Indent $text $indent }}
    ```
    <div class="result" sh>
    <pre>
	Indented: 
        line1
        line2
    </pre>
    </div>

    In this `example`, the Indent method is used to add four spaces before each line of the text, resulting in the output with the added indentation.







### string.IndentAuto

**Description**

The `IndentAuto` method automatically adds the existing indentation from the first line of the text to all lines in the text. If the text has no lines, it returns the original text.


**Signature**
```
IndentAuto(text String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `text` | [`String`][String] | The text to which the existing indentation will be added. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The text with the existing indentation automatically added. |



!!! example

    ```go
    {{ $text := "  line1\n  line2" }}
    Auto Indented: {{ string.IndentAuto $text }}
    ```
    <div class="result" sh>
    <pre>
	Auto Indented: 
        line1
        line2
    </pre>
    </div>

    In this example, the `IndentAuto` method automatically detects the indentation from the first line and applies it to all lines in the text.






### string.ArrayToStringSlice

**Description**

The `ArrayToStringSlice` method converts an array of [`[]Object`][Object] to a slice of strings, filtering out any non-string values.


**Signature**
```
ArrayToStringSlice(arr []Object) []string
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `arr`  | [`[]Object`][Object]   | The array to convert to a slice of strings. |


**Return**

| Type | Description | 
|------|-------------|
| [`[]String`][String]       | A slice of strings extracted from the array. |



!!! example

    ```go
    {{ $arr := slice "one" 2 "three" }}
    String Slice: {{ string.ArrayToStringSlice $arr }}
    ```
    <div class="result" sh>
    <pre>
	String Slice: [one three]
    </pre>
    </div>


    In this example, the `ArrayToStringSlice` method converts an array containing strings and non-strings into a slice containing only the strings.



























## Regexp





### regexp.Find

**Description**

The `Find` method searches for the first occurrence of the regular expression `expression` within the `input` string and returns the matching substring.


**Signature**
```
Find(expression String, input String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| expression  | [`String`][String] | The regular expression to compile and use for searching. |
| input       | [`String`][String] | The input string in which to search for the regular expression. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String]  | The first substring that matches the regular expression. |



!!! example

    ```go
    {{ $pattern := "\\d+" }}
    {{ $input := "The price is 42 dollars." }}
    {{ $match, $err := regex.Find $pattern $input }}
    {{ if $err }}
        <p>Error: {{ $err }}</p>
    {{ else }}
        <p>Match: {{ $match }}</p>
    {{ end }}
    ```
    <div class="result" sh>
    <pre>
	Match: 42
    </pre>
    </div>

    In this example, the `Find` method is utilized within the template to search for the first occurrence of the pattern `\d+` in the input string `"The price is 42 dollars."`, resulting in the output `Match: 42`.





### regexp.FindAll

**Description**

The `FindAll` method in the `regexp` type searches for all occurrences of a regular expression pattern within a given input string. It returns up to `n` matches.


**Signature**
```
FindAll(expression String, n Int, input String) []String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `expression` | [`String`][String] | The regular expression pattern to search for. |
| `n`          | [`Int`][Int]    | The maximum number of matches to return.        |
| `input`      | [`String`][String] | The input string to search within.              |


**Return**

| Type | Description | 
|------|-------------|
| [`[]String`][String] | A slice of strings containing matches.  |



!!! example

    ```go
    {{ $expression := "\\d+" }}
    {{ $input := "The prices are 20, 30, and 40 dollars." }}
    {{ $matches := regex.FindAll $expression 3 $input }}
    Matches found: {{ $matches }}
    ```
    <div class="result" sh>
    <pre>
	Matches found: [20 30 40]
    </pre>
    </div>

    In this example, the `FindAll` method is utilized within the template to search for all occurrences of the pattern `\d+` in the input string `"The prices are 20, 30, and 40 dollars."`, returning up to 3 matches. The result is `Matches found: [20 30 40]`.




### regexp.Match

**Description**

The `Match` method in the `regexp` space checks if the input string matches the given regular expression. It returns a boolean indicating whether the match was successful and an error if the regular expression compilation fails.


**Signature**
```
Match(expression String, input String) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `expression` | [`String`][String] | The regular expression to match against.          |
| `input`     | [`String`][String] | The input string to check for a match.            |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]      | `true` if the input string matches the regular expression, `false` otherwise. |



!!! example

    ```go
    {{ $expression := "^Hello" }}
    {{ $input := "Hello, world!" }}
    Does the input match? {{ regex.Match $expression $input }}
    ```
    <div class="result" sh>
    <pre>
	Does the input match? true
    </pre>
    </div>

    In this example, the `Match` method is utilized within the template to check if the input string `"Hello, world!"` starts with the regular expression `^Hello`, resulting in the output `Does the input match? true`.







### regexp.QuoteMeta

**Description**

The `QuoteMeta` method returns a string with all the special characters escaped. This is useful when you need to use a literal string as a regular expression.

**Signature**
```
QuoteMeta(input String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `input`     | [`String`][String] | The input string to escape for use in a regular expression. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String]    | The input string with all special characters escaped. |



!!! example

    ```go
    {{ $input := "Hello.*World" }}
    Quoted meta: {{ regex.QuoteMeta $input }}
    ```
    <div class="result" sh>
    <pre>
	Quoted meta: Hello\.\\*World
    </pre>
    </div>

    In this example, the `QuoteMeta` method is utilized within the template to escape special characters in the string `"Hello.*World"`, resulting in the output `Quoted meta: Hello\.\\*World`.





### regexp.Replace

**Description**

The `Replace` method replaces all occurrences of the regular expression pattern in the input string with the replacement string.

**Signature**
```
Replace(expression String, replacement String, input String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `expression`  | [`String`][String] | The regular expression to search for.            |
| `replacement` | [`String`][String] | The string to replace the matches with.          |
| `input`       | [`String`][String] | The input string to perform the replacements on. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String]    | The resulting string after replacements.         |



!!! example

    ```go
    {{ $expression := "world" }}
    {{ $replacement := "universe" }}
    {{ $input := "Hello, world!" }}
    Replaced: {{ regex.Replace $expression $replacement $input }}
    ```
    <div class="result" sh>
    <pre>
	Replaced: Hello, universe!
    </pre>
    </div>

    In this example, the `Replace` method is utilized within the template to replace occurrences of `"world"` with `"universe"` in the string `"Hello, world!"`, resulting in the output `Replaced: Hello, universe!`.






### regexp.ReplaceLiteral

**Description**

The `ReplaceLiteral` method performs a literal replacement of all occurrences of the pattern in the input string with the replacement string. Unlike `Replace`, this does not interpret the pattern as a regular expression.


**Signature**
```
ReplaceLiteral(expression String, replacement String, input String) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `expression`  | [`String`][String] | The literal string to search for.                |
| `replacement` | [`String`][String] | The string to replace the matches with.          |
| `input`       | [`String`][String] | The input string to perform the replacements on. |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String]    | The resulting string after literal replacements. |



!!! example

    ```go
    {{ $expression := "world" }}
    {{ $replacement := "universe" }}
    {{ $input := "Hello, world!" }}
    Replaced literal: {{ regex.ReplaceLiteral $expression $replacement $input }}
    ```
    <div class="result" sh>
    <pre>
	Replaced literal: Hello, universe!
    </pre>
    </div>


    In this example, the `ReplaceLiteral` method is utilized within the template to replace occurrences of the literal string `"world"` with `"universe"` in the string `"Hello, world!"`, resulting in the output `Replaced literal: Hello, universe!`.






### regexp.Split

**Description**

The `Split` method splits the input string around each match of the regular expression. The `n` parameter controls the number of substrings to return.


**Signature**
```
Split(expression String, n Int, input String) []String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `expression`  | [`String`][String] | The regular expression to split the string by.  |
| `n`           | [`Int`][Int] | The maximum number of substrings to return. If `n` is less than 0, there is no limit. |
| `input`       | [`String`][String] | The input string to split.                       |


**Return**

| Type | Description | 
|------|-------------|
| [`[]String`][String]  | A slice of substrings split around the regular expression. |



!!! example

    ```go
    {{ $expression := "\\s" }}
    {{ $n := 2 }}
    {{ $input := "Hello world from Pars" }}
    Split result: {{ regex.Split $expression $n $input }}
    ```
    <div class="result" sh>
    <pre>
	Split result: [Hello world from Pars]
    </pre>
    </div>

    In this example, the `Split` method is utilized within the template to split the string `"Hello world from Pars"` around spaces (`\s`), resulting in the output `Split result: [Hello world from Pars]`.




## Array




### array.Slice
**Description**

The `Slice` method in the `array` space takes a variable number of arguments and returns them as a slice of `interface{}`. This is useful for creating slices from a list of values within a template.



**Signature**
```
Slice(args ...Object) []Object
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`args`|[`...Object`][Object]| The values to be included in the slice |



**Return**

| Type | Description | 
|------|-------------|
|[`[]Object`][Object]  | A slice containing the provided values|



!!! example

    ```go
    {{ $a := 1 }}
    {{ $b := "two" }}
    {{ $c := 3.0 }}
    The slice contains: {{ array.Slice $a $b $c }}

    ```
    <div class="result" sh>
    <pre>
    The slice contains: [1 two 3]
    </pre>
    </div>

    In this example, the `Slice` method is utilized within the template to create a slice containing the values 1, "two", and 3.0, resulting in the output `The slice contains: [1 two 3]`.





### array.Has 

**Description**

The `Has` method in the `array` space checks if a map, slice, or array contains a specific key or value. It takes two `Object` parameters: the collection and the key or value to check for, and returns `true` if the key or value is found, otherwise returns `false`.




**Signature**
```
Has(in []Object, key String) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`in`  |[`[]Object`][Object]  | The collection to be checked    |
|`key` |[`String`][String]  | The key or value to check for   |


**Return**

| Type | Description | 
|------|-------------|
|[`Boolean`][Boolean]  | \`true\` if \`key\` is found, else \`false\` |



!!! example

    ```go
    {{ $list := slice "one" "two" "three" }}
    Does the list contain "two"? {{ array.Has $list "two" }}
    ```
    <div class="result" sh>
    <pre>
    Does the list contain "two"? true
    </pre>
    </div>


    In this example, the `Has` method is utilized within the template to check if the list contains "two", resulting in the output `Does the list contain "two"? true`.




### array.Append

**Description**

The `Append` method in the `array` space adds an element to the end of a slice. It takes two `Object` parameters: the value to append and the slice to append to, and returns the updated slice.


**Signature**
```
Append(v Object, list []Object) []Object

```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`v`   |[`Object`][Object]  | The value to append             |
|`list`|[`[]Object`][Object]  | The slice to append to          |


**Return**

| Type | Description | 
|------|-------------|
|[`[]Object`][Object]   | The updated slice                     |



!!! example

    ```go
	{{ $list := slice "one" "two" }}
    The updated list is: {{ array.Append "three" $list }}
    ```
    <div class="result" sh>
    <pre>
    The updated list is: [one two three]
    </pre>
    </div>

    In this example, the `Append` method is utilized within the template to add "three" to the end of the list, resulting in the output `The updated list is: [one two three]`.





### array.Prepend

**Description**

The `Prepend` method in the `array` space adds an element to the beginning of a slice. It takes two `Object` parameters: the value to prepend and the slice to prepend to, and returns the updated slice.


**Signature**
```
Prepend(v Object, list Object) []Object
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`v`   |[`Object`][Object]  | The value to prepend            |
|`list`|[`[]Object`][Object]  | The slice to prepend to         |


**Return**

| Type | Description | 
|------|-------------|
|[`[]Object`][Object]   | The updated slice                     |



!!! example

    ```go
	{{ $list := slice "one" "two" }}
    The updated list is: {{ array.Prepend "zero" $list }}
    ```
    <div class="result" sh>
    <pre>
    The updated list is: [zero one two]
    </pre>
    </div>

    In this example, the `Prepend` method is utilized within the template to add "zero" to the beginning of the list, resulting in the output `The updated list is: [zero one two]`.





### array.Uniq

**Description**


The `Uniq` method in the `array` space removes duplicate elements from a slice. It takes one `Object` parameter: the slice to process, and returns a new slice with duplicates removed.


**Signature**
```
Uniq(list []Object) []Object
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`list`|[`[]Object`][Object]  | The slice to process            |


**Return**

| Type | Description | 
|------|-------------|
|[`[]Object`][Object]   | The slice with duplicates removed     |



!!! example

    ```go
	{{ $list := slice "one" "two" "one" "three" "two" }}
    The unique list is: {{ array.Uniq $list }}
    ```
    <div class="result" sh>
    <pre>
    The unique list is: [one two three]
    </pre>
    </div>

    In this example, the `Uniq` method is utilized within the template to remove duplicate values from the list, resulting in the output `The unique list is: [one two three]`.





### array.Reverse

**Description**

The `Reverse` method in the `array` space reverses the order of elements in a slice. It takes one `Object` parameter: the slice to reverse, and returns a new slice with the elements in reverse order.


**Signature**
```
Reverse(list []Object) []Object
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`list`|[`[]Object`][Object]  | The slice to reverse            |


**Return**

| Type | Description | 
|------|-------------|
| [`[]Object`][Object]   | The reversed slice |



!!! example

    ```go
    {{ $list := slice "one" "two" "three" }}
    The reversed list is: {{ array.Reverse $list }}

    ```
    <div class="result" sh>
    <pre>
    The reversed list is: [three two one]
    </pre>
    </div>


    In this example, the `Reverse` method is utilized within the template to reverse the order of the list, resulting in the output `The reversed list is: [three two one]`.




### array.Sort

**Description**

The `Sort` method in the `array` space sorts a slice of elements based on a specified key. It takes two `Object` parameters: the key to sort by and the slice to sort. It returns a new sorted slice and an error if the operation fails.


**Signature**
```
Sort(key String, list []Object) []Object
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`key` | [`String`][String]  | The key to sort by              |
|`list`| [`[]Object`][Object]  | The slice to sort               |


**Return**

| Type | Description | 
|------|-------------|
| [`[]Object`][Object]   | The sorted slice |



!!! example

    ```go
    {{ $list := slice (dict "name" "Alice" "age" 30) (dict "name" "Bob" "age" 25) (dict "name" "Charlie" "age" 35) }}
    The sorted list by age is: {{ array.Sort "age" $list }}
    ```
    <div class="result" sh>
    <pre>
    The sorted list by age is: [{name:Bob age:25} {name:Alice age:30} {name:Charlie age:35}]
    </pre>
    </div>

    In this example, the `Sort` method is utilized within the template to sort the list of dictionaries by the key "age", resulting in the output `The sorted list by age is: [{name:Bob age:25} {name:Alice age:30} {name:Charlie age:35}]`.







### array.Flatten

**Description**

The `Flatten` method in the `array` space flattens a nested slice or array up to a specified depth. It takes two parameters: the slice or array to flatten and the depth to which to flatten it. It returns a new flattened slice and an error if the operation fails.


**Signature**
```
Flatten(list []Object, depth Int) []Object

```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`list` | [`[]Object`][Object]  | The slice or array to flatten       |
|`depth`| [`Int`][Int]     | The depth to which to flatten       |


**Return**

| Type | Description | 
|------|-------------|
| [`[]Object`][Object]   | The flattened slice |



!!! example

    ```go
	{{ $nestedList := slice (slice 1 2) (slice 3 (slice 4 5)) 6 }}
    The flattened list is: {{ array.Flatten $nestedList 1 }}

    ```
    <div class="result" sh>
    <pre>
    The flattened list is: [1 2 3 [4 5] 6]
    </pre>
    </div>

    In this example, the `Flatten` method is utilized within the template to flatten the nested list to a depth of 1. The resulting output is `The flattened list is: [1 2 3 [4 5] 6]`.






### array.IsFirst

**Description**

The `IsFirst` method in the `array` space checks if a given index is the first position (i.e., index 0) in a slice. It takes two parameters: the index and the slice to check. It returns `true` if the index is 0, otherwise `false`.


**Signature**
```
IsFirst(index Int, slice []Object) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`index` | [`Int`][Int]     | The index to check            |
|`slice` | [`[]Object`][Object]  | The slice to check            |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]  | \`true\` if the index is 0, else \`false\` |



!!! example

    ```go
    {{ $list := slice "a" "b" "c" }}
    Is index 0 the first? {{ array.IsFirst 0 $list }}
    ```
    <div class="result" sh>
    <pre>
    Is index 0 the first? true
    </pre>
    </div>

    In this example, the `IsFirst` method is utilized within the template to check if index 0 is the first position in the list, resulting in the output `Is index 0 the first? true`.





### array.IsLast

**Description**

The `IsLast` method in the `array` space checks if a given index is the last position in a slice. It takes two parameters: the index and the slice to check. It returns `true` if the index is the last position, otherwise `false`.


**Signature**
```
IsLast(index Int, slice []Object) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `index` | [`Int`][Int]     | The index to check            |
|`slice` | [`[]Object`][Object]  | The slice to check            |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]  | \`true\` if the index is the last position, else \`false\` |



!!! example

    ```go
    {{ $list := slice "a" "b" "c" }}
    Is index 2 the last? {{ array.IsLast 2 $list }}
    ```
    <div class="result" sh>
    <pre>
    Is index 2 the last? true
    </pre>
    </div>


    In this example, the `IsLast` method is utilized within the template to check if index 2 is the last position in the list, resulting in the output `Is index 2 the last? true`.





### array.HasElements

**Description**

The `HasElements` method in the `array` space checks if a slice contains any elements. It takes one parameter: the slice to check. It returns `true` if the slice has more than 0 elements, otherwise `false`.


**Signature**
```
HasElements(slice []Object) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`slice` | [`[]Object`][Object]  | The slice to check           |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]  | \`true\` if the slice has elements, else \`false\` |



!!! example

    ```go
    {{ $list := slice "a" "b" "c" }}
    Does the list have elements? {{ array.HasElements $list }}
    ```
    <div class="result" sh>
    <pre>
    Does the list have elements? true
    </pre>
    </div>


    In this example, the `HasElements` method is utilized within the template to check if the list has any elements, resulting in the output `Does the list have elements? true`.













### array.Count

**Description**

The `Count` method in the `array` space returns the number of elements in a slice. It takes one parameter: the slice to count. It returns the count of elements as an `int`.


**Signature**
```
Count(slice []Object) Int
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`slice`| [`[]Object`][Object]  | The slice to count         |


**Return**

| Type | Description | 
|------|-------------|
| [`Int`][Int]  | The number of elements in the slice |



!!! example

    ```go
    {{ $list := slice "a" "b" "c" }}
    The number of elements is: {{ array.Count $list }}
    ```
    <div class="result" sh>
    <pre>
    The number of elements is: 3
    </pre>
    </div>


    In this example, the `Count` method is utilized within the template to count the number of elements in the list, resulting in the output `The number of elements is: 3`.









### array.First

**Description**

The `First` method in the `array` space returns the first element of a slice. It takes one parameter: the slice to check. It returns the first element if the slice is not empty; otherwise, it returns `nil`.


**Signature**
```
First(slice []Object) Object
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`slice`| [`[]Object`][Object]  | The slice to check           |


**Return**

| Type | Description | 
|------|-------------|
| [`Object`][Object]  | The first element of the slice, or \`nil\` if the slice is empty |



!!! example

    ```go
    {{ $list := slice "a" "b" "c" }}
    The first element is: {{ array.First $list }}
    ```
    <div class="result" sh>
    <pre>
    The first element is: a
    </pre>
    </div>


    In this example, the `First` method is utilized within the template to get the first element of the list, resulting in the output `The first element is: a`.






### array.Last

**Description**

The `Last` method in the `array` space returns the last element of a slice. It takes one parameter: the slice to check. It returns the last element if the slice is not empty; otherwise, it returns `nil`.


**Signature**
```
Last(slice []Object) Object

```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`slice`| [`[]Object`][Object]  | The slice to check           |


**Return**

| Type | Description | 
|------|-------------|
| [`Object`][Object]  | The last element of the slice, or \`nil\` if the slice is empty |



!!! example

    ```go
    {{ $list := slice "a" "b" "c" }}
    The last element is: {{ array.Last $list }}
    ```
    <div class="result" sh>
    <pre>
    The last element is: c
    </pre>
    </div>


    In this example, the `Last` method is utilized within the template to get the last element of the list, resulting in the output `The last element is: c`.






### array.Contains

**Description**

The `Contains` method in the `array` space checks if a slice contains a specified value. For slices of struct types, it searches for the value in a specified field. It takes three parameters: the slice to search, the key (if searching within structs), and the value to search for. It returns `true` if the value is found; otherwise, `false`.


**Signature**
```
Contains(slice []Object, key String, value Object) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`slice`| [`[]Object`][Object]  | The slice to search                             |
|`key`  | [`String`][String]  | The field name to search within structs (can be empty) |
|`value`| [`Object`][Object]  | The value to search for                         |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]  | \`true\` if the value is found in the slice, else \`false\` |



!!! example

    ```go
    {{ $list := slice (struct "Name" "Alice") (struct "Name" "Bob") }}
    Does the list contain "Alice"? {{ array.Contains $list "Name" "Alice" }}

    ```
    <div class="result" sh>
    <pre>
    Does the list contain "Alice"? true
    </pre>
    </div>

    In this example, the `Contains` method is utilized within the template to check if the list contains an item where the "Name" field is "Alice", resulting in the output `Does the list contain "Alice"? true`.







### array.Find

**Description**

The `Find` method in the `array` space searches for an item in a slice that matches a specified value. For slices of struct types, it searches for the value in a specified field. It takes three parameters: the slice to search, the key (if searching within structs), and the value to find. It returns the found item or `nil` if no match is found.


**Signature**
```
Find(slice []Object, key String, value Object) Object
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`slice`| [`[]Object`][Object]  | The slice to search                             |
|`key`  | [`String`][String]  | The field name to search within structs (can be empty) |
|`value`| [`Object`][Object]  | The value to find                               |


**Return**

| Type | Description | 
|------|-------------|
| [`Object`][Object]  | The found item or \`nil\` if no match is found |



!!! example

    ```go
    {{ $list := slice (struct "Name" "Alice") (struct "Name" "Bob") }}
    The item with Name "Alice" is: {{ array.Find $list "Name" "Alice" }}

    ```
    <div class="result" sh>
    <pre>
    The item with Name "Alice" is: {Name: Alice}
    </pre>
    </div>


    In this example, the `Find` method is utilized within the template to locate an item where the "Name" field is "Alice", resulting in the output `The item with Name "Alice" is: {Name: Alice}`.








### array.Filter

**Description**

The `Filter` method in the `array` space filters a slice or a single struct based on a specified path and value. It returns a slice of items that match the criteria. It takes three parameters: the data to filter, the path to the field (for nested structs), and the value to filter by. It returns a slice of items that match the criteria.


**Signature**
```
Filter(data []Object, path String, value String) []Object
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`data` | [`Object`][Object]  | The slice or struct to filter                |
|`path` | [`String`][String]  | The path to the field to filter by (e.g., "Field.SubField") |
|`value`| [`String`][String]  | The value to filter by                      |


**Return**

| Type | Description | 
|------|-------------|
| [`[]Object`][Object]  | A slice of items that match the filter criteria |



!!! example

    ```go
    {{ $data := slice (struct "Info" (struct "Name" "Alice")) (struct "Info" (struct "Name" "Bob")) }}
    Filtered items where Info.Name is "Alice": {{ array.Filter $data "Info.Name" "Alice" }}

    ```
    <div class="result" sh>
    <pre>
    Filtered items where Info.Name is "Alice": [{Info: {Name: Alice}}]
    </pre>
    </div>

    In this example, the `Filter` method is utilized within the template to filter items where the "Info.Name" field is "Alice", resulting in the output `Filtered items where Info.Name is "Alice": [{Info: {Name: Alice}}]`.




## Map




### map.Dictionary

**Description**


The `Dictionary` method creates a map from a series of key-value pairs provided as arguments. It expects an even number of arguments; the first argument is the key and the second is the value. The method converts the keys to strings and handles values that might be pointers.

**Signature**
```
Dictionary(v ...Object) Map[String, Object]
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `v`  | [`...Object`][Object]  | A series of alternating keys and values to be converted into a map. |


**Return**

| Type | Description | 
|------|-------------|
| [`Map[String, Object]`][Object]  | A map where keys are strings and values are the corresponding values provided. |



!!! example

    ```go
    {{ $dict := map.Dictionary "key1" "value1" "key2" "value2" }}
    Key1: {{ $dict.key1 }}
    Key2: {{ $dict.key2 }}
    ```
    <div class="result" sh>
    <pre>
    Key1: value1
    Key2: value2
    </pre>
    </div>


    In this example, the `Dictionary` method is used to create a map from key-value pairs provided in the arguments.





### map.Has

**Description**

The `Has` method checks if a given key or value exists within a map or slice. For maps, it checks if the specified key exists. For slices and arrays, it checks if the specified value exists within the array.


**Signature**
```
Has(in Map[String, Object], key String) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `in` | [`Map[String, Object]`][Object] | The map, slice, or array to search within.      |
| `key`| [`String`][String] | The key to check in the map, or the value to check in the slice/array. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean]| `true` if the key or value exists; otherwise, `false`. |



!!! example

    ```go
    {{ $map := map.Dictionary "key1" "value1" "key2" "value2" }}
    Key exists: {{ map.Has $map "key1" }}
    Value exists: {{ map.Has $map "value2" }}
    ```
    <div class="result" sh>
    <pre>
    Key exists: true
    Value exists: true
    </pre>
    </div>


    In this example, the `Has` method is used to check for the existence of a key and a value in a map. It returns `true` for both checks.





### map.HasKey

**Description**

The `HasKey` method checks if a given key exists in a map. It returns `true` if the key is present in the map; otherwise, it returns `false`.


**Signature**
```
HasKey(m Map[String, Object], key String) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `m`  | [`Map[String, Object]`][Object] | The map to check for the presence of the key. |
| `key`| [`String`][String]              | The key to check in the map.                  |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean] | `true` if the key exists in the map; otherwise, `false`. |



!!! example

    ```go
    {{ $map := map.Dictionary "key1" "value1" "key2" "value2" }}
    Key1 exists: {{ map.HasKey $map "key1" }}
    Key3 exists: {{ map.HasKey $map "key3" }}
    ```
    <div class="result" sh>
    <pre>
    Key1 exists: true
    Key3 exists: false
    </pre>
    </div>

    In this example, the `Dictionary` method is used to create a map from key-value pairs provided in the arguments.





### map.Keys

**Description**

The `Keys` method retrieves all keys from one or more maps. If no maps are provided, it returns an error.


**Signature**
```
Keys(in ...Map[String, Object]) []String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `in` | [`Map[String, Object]`][Object] | One or more maps from which to extract keys. |


**Return**

| Type          | Description |
|---------------|-------------|
| [`[]String`][String]         | A slice of keys extracted from the maps.   |



!!! example

    ```go
    {{ $map1 := map.Dictionary "key1" "value1" "key2" "value2" }}
    {{ $map2 := map.Dictionary "key3" "value3" "key4" "value4" }}
    Keys: {{ map.Keys $map1 $map2 }}
    ```
    <div class="result" sh>
    <pre>
    Keys: [key1 key2 key3 key4]
    </pre>
    </div>


    In this example, the `Keys` method retrieves all keys from the provided maps.






### map.Values

**Description**

The `Values` method retrieves all values from one or more maps. If no maps are provided, it returns an error.


**Signature**
```
Values(in ...Map[String, Object]) []Object
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `in` | [`Map[String, Object]`][Object] | One or more maps from which to extract values. |


**Return**

| Type | Description | 
|------|-------------|
| `in` | [`[]Object`][Object] | One or more maps from which to extract values. |



!!! example

    ```go
    {{ $map1 := map.Dictionary "key1" "value1" "key2" "value2" }}
    {{ $map2 := map.Dictionary "key3" "value3" "key4" "value4" }}
    Values: {{ map.Values $map1 $map2 }}
    ```
    <div class="result" sh>
    <pre>
    Values: [value1 value2 value3 value4]
    </pre>
    </div>



    In this example, the `Values` method retrieves all values from the provided maps.





### map.Merge

**Description**

The `Merge` method combines multiple source maps into a destination map. If a key exists in multiple source maps, the value from the last map is used.


**Signature**
```
Merge(dst Map[String, Object], srcs ...Map[String, Object]) Map[String, Object]
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `dst`| [`Map[String, Object]`][Object]    | The destination map to which source maps are merged. |
| `srcs`| [`...Map[String, Object]`][Object] | One or more source maps to merge into the destination map. |


**Return**

| Type | Description | 
|------|-------------|
| [`Map[String, Object]`][Object]   | The merged map containing all key-value pairs from the source maps. |



!!! example

    ```go
    {{ $map1 := map.Dictionary "key1" "value1" "key2" "value2" }}
    {{ $map2 := map.Dictionary "key2" "updatedValue2" "key3" "value3" }}
    {{ $merged := map.Merge $map1 $map2 }}
    Merged: {{ $merged.key1 }}, {{ $merged.key2 }}, {{ $merged.key3 }}
    ```
    <div class="result" sh>
    <pre>
    Merged: value1, updatedValue2, value3
    </pre>
    </div>


    In this example, the `Merge` method combines the key-value pairs from `$map1` and `$map2`, with the value from `$map2` overwriting any matching keys.






### map.Omit

**Description**

The `Omit` method creates a new map by excluding specified keys from the original map.


**Signature**
```
Omit(in Map[String, Object], keys ...String) Map[String, Object]
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `in` | [`Map[String, Object]`][Object] | The original map from which to omit keys.    |
| `keys` | [`...String`][String]           | The keys to omit from the original map.      |


**Return**

| Type | Description | 
|------|-------------|
| [`Map[String, Object]`][Object]    | A new map with specified keys omitted.   |



!!! example

    ```go
    {{ $map := map.Dictionary "key1" "value1" "key2" "value2" "key3" "value3" }}
    {{ $omitted := map.Omit $map "key2" }}
    Omitted: {{ $omitted.key1 }}, {{ $omitted.key3 }}
    ```
    <div class="result" sh>
    <pre>
    Omitted: value1, value3
    </pre>
    </div>

    In this example, the `Omit` method creates a new map excluding `key2` from the original map.






### map.Pick

**Description**

The `Pick` method creates a new map containing only the specified keys from the original map.


**Signature**
```
Pick(in Map[String, Object], keys ...String) Map[String, Object]
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `in` | [`Map[String, Object]`][Object] | The original map from which to pick keys.    |
| `keys` | [`[]String`][String]           | The keys to pick from the original map.      |


**Return**

| Type | Description | 
|------|-------------|
| [`Map[String, Object]`][Object]    | A new map containing only the specified keys. |



!!! example

    ```go
    {{ $map := map.Dictionary "key1" "value1" "key2" "value2" "key3" "value3" }}
    {{ $picked := map.Pick $map "key1" "key3" }}
    Picked: {{ $picked.key1 }}, {{ $picked.key3 }}
    ```
    <div class="result" sh>
    <pre>
    Picked: value1, value3
    </pre>
    </div>


In this example, the `Pick` method creates a new map containing only `key1` and `key3` from the original map.

## Convert




### convert.ToBool

**Description**

The `ToBool` method in the `convert` space converts an input value to a boolean. It takes one parameter of any type and returns `true` or `false` based on the input's value. The method handles various types including boolean, string, integer, and float, converting them to a boolean representation.





**Signature**
```
ToBool(in Object) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`in`  | [`Object`][Object] | The input value to convert |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean] | The boolean representation of the input |



!!! example

    ```go
    {{ $input := "true" }}
    The boolean value of "{{ $input }}" is {{ convert.ToBool $input }}
    ```
    <div class="result" sh>
    <pre>
    The boolean value of "true" is true
    </pre>
    </div>

    In this example, the `ToBool` method is utilized within the template to convert the string `"true"` to its boolean representation, resulting in the output `The boolean value of "true" is true`.






### convert.ToString

**Description**

The `ToString` method in the `convert` space converts an input value to a string. It takes one parameter of any type and returns its string representation. The method handles various types including string, `fmt.Stringer`, byte slice, and others by converting them appropriately.


**Signature**
```
ToString(in Object) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `in`  | [`Object`][Object] | The input value to convert |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String] | The string representation of the input |



!!! example

    ```go
    {{ $input := 123 }}
    The string value of {{ $input }} is "{{ convert.ToString $input }}"
    ```
    <div class="result" sh>
    <pre>
    The string value of 123 is "123"
    </pre>
    </div>


    In this example, the `ToString` method is utilized within the template to convert the integer `123` to its string representation, resulting in the output `The string value of 123 is "123"`.







### convert.ToInt64

**Description**

The `ToInt64` method in the `convert` space converts an input value to an `int64`. It takes one parameter of any type and returns its `int64` representation or an error if the conversion fails.


**Signature**
```
ToInt64(v Object) Int64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`v`   | [`Object`][Object] | The input value to convert |


**Return**

| Type | Description | 
|------|-------------|
| [`Int64`][Int64] | The int64 representation of the input |



!!! example

    ```go
    {{ $input := "123" }}
    The int64 value of {{ $input }} is {{ convert.ToInt64 $input }}
    ```
    <div class="result" sh>
    <pre>
    The int64 value of 123 is 123
    </pre>
    </div>

    In this example, the `ToInt64` method is utilized within the template to convert the string `"123"` to its int64 representation, resulting in the output `The int64 value of 123 is 123`.







### convert.ToInt

**Description**

The `ToInt` method in the `convert` space converts an input value to an int. It takes one parameter of any type and attempts to convert it to an int. It returns the result along with any conversion error encountered.


**Signature**
```
ToInt(in Object) Int
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `in`  | [`Object`][Object] | The input value to convert |


**Return**

| Type | Description | 
|------|-------------|
| [`Int`][Int]  | The int representation of the input |



!!! example

    ```go
    {{ $input := "123" }}
    The int value of {{ $input }} is {{ convert.ToInt $input }}
    ```
    <div class="result" sh>
    <pre>
    The int value of 123 is 123
    </pre>
    </div>

    In this example, the `ToInt` method is utilized within the template to convert the string `"123"` to its int representation, resulting in the output `The int value of 123 is 123`.






### convert.ToInt64s

**Description**

The `ToInt64s` method in the `convert` space converts a variadic list of input values to a slice of int64. It takes multiple parameters of any type and attempts to convert them to int64 values. It returns the slice of int64 values along with any conversion error encountered.


**Signature**
```
ToInt64s(in ...Object) []Int64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `in`  | [`...Object`][Object] | The input values to convert |


**Return**

| Type | Description | 
|------|-------------|
| [`Int64`][Int64] | The slice of int64 representations of the inputs |



!!! example

    ```go
    {{ $input1 := "123" }}
    {{ $input2 := 456 }}
    {{ $result, $err := convert.ToInt64s $input1 $input2 }}
    The int64 values are {{ $result }}
    ```
    <div class="result" sh>
    <pre>
    The int64 values are [123 456]
    </pre>
    </div>

    In this example, the `ToInt64s` method is utilized within the template to convert the string `"123"` and the integer `456` to their int64 representations, resulting in the output `The int64 values are [123 456]`.





### convert.ToInts

**Description**

The `ToInts` method in the `convert` space converts a variadic list of input values to a slice of int. It takes multiple parameters of any type and attempts to convert them to int values. It returns the slice of int values along with any conversion error encountered.


**Signature**
```
ToInts(in ...Object) []Int64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`in`  | [`...Object`][Object]| The input values to convert |


**Return**

| Type | Description | 
|------|-------------|
| [`[]Int64`][Int64] | The slice of int representations of the inputs |



!!! example

    ```go
    {{ $input1 := "123" }}
    {{ $input2 := 456 }}
    {{ $result, $err := convert.ToInts $input1 $input2 }}
    The int values are {{ $result }}
    ```
    <div class="result" sh>
    <pre>
    The int values are [123 456]
    </pre>
    </div>

    In this example, the `ToInts` method is utilized within the template to convert the string `"123"` and the integer `456` to their int representations, resulting in the output `The int values are [123 456]`.





### convert.ToFloat64

**Description**

The `ToFloat64` method in the `convert` space converts an input value to a float64. It attempts to convert various types of inputs, including strings, integers, unsigned integers, floating-point numbers, and booleans, to their float64 representations. It returns the float64 value along with any conversion error encountered.


**Signature**
```
ToFloat64(v Object) Float64
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`v`   | [`Object`][Object] | The input value to convert |


**Return**

| Type | Description | 
|------|-------------|
| [`Float64`][Float64] | The float64 representation of the input |



!!! example

    ```go
    {{ $input := "123.45" }}
    {{ $result, $err := convert.ToFloat64 $input }}
    The float64 value is {{ $result }}
    ```
    <div class="result" sh>
    <pre>
    The float64 value is 123.45
    </pre>
    </div>


    In this example, the `ToFloat64` method is utilized within the template to convert the string `"123.45"` to its float64 representation, resulting in the output `The float64 value is 123.45`.


## Data




### data.Default

**Description**

The `Default` method returns the given `defaultValue` if the `value` is considered "empty" based on its type. It checks various types and their default "empty" values, such as null, zero for numeric types, empty strings, slices, maps, etc. If the value is empty, it returns `defaultValue`; otherwise, it returns the `value` itself.


**Signature**
```
Default(value Object, defaultValue Object) Object
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `value`       | [`Object`][Object] | The value to check and potentially return.    |
| `defaultValue`| [`Object`][Object] | The value to return if `value` is considered empty. |


**Return**

| Type | Description | 
|------|-------------|
| [`Object`][Object] | The `value` if it is not empty; otherwise, `defaultValue`. |



!!! example

    ```go
    {{ $value := "" }}
    {{ $default := "default" }}
    The result is {{ data.Default $value $default }}
    ```
    <div class="result" sh>
    <pre>
    The result is default
    </pre>
    </div>



    In this example, the `Default` method is used within the template to return "default" because the `value` is an empty string.




### data.IsDefault

**Description**

The `IsDefault` method checks if a given value is considered "empty" based on its type. It returns `true` if the value is nil or has a default "empty" state for its type (such as zero for numeric types, empty strings, slices, maps, etc.). Otherwise, it returns `false`.

**Signature**
```
IsDefault(value Object) Boolean
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `value`| [`Object`][Object] | The value to check if it is in its default state. |


**Return**

| Type | Description | 
|------|-------------|
| [`Boolean`][Boolean] | `true` if the value is in its default state; otherwise, `false`. |



!!! example

    ```go
    {{ $value := 0 }}
    The value is default: {{ data.IsDefault $value }}
    ```
    <div class="result" sh>
    <pre>
    The value is default: true
    </pre>
    </div>


    In this example, the `IsDefault` method checks if `value` is `0`, which is considered its default state for integers. The result is `true` since `0` is the default value for integers.

## Base64





### base64.Encode

**Description**

The `Encode` method in the `base64` space encodes a byte array into a base64 encoded string. This method uses the standard base64 encoding scheme to convert the input bytes into a string representation.


**Signature**
```
Encode(in []Byte) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`in`  | [`[]Byte`][Byte]  | The input byte array to encode |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String]  | The base64 encoded string          |



!!! example

    ```go
    {{ $input := []byte "Hello, World!" }}
    {{ $encoded, $err := base64.Encode $input }}
    The base64 encoded string is {{ $encoded }}
    ```
    <div class="result" sh>
    <pre>
    The base64 encoded string is SGVsbG8sIFdvcmxkIQ==
    </pre>
    </div>


    In this example, the `Encode` method is utilized within the template to convert the byte array `"Hello, World!"` to its base64 encoded string representation, resulting in the output `The base64 encoded string is SGVsbG8sIFdvcmxkIQ==`.






### base64.Decode

**Description**

The `Decode` method in the `base64` space decodes a base64 encoded string into a byte array. This method first attempts to decode the input string using the standard base64 encoding scheme. If it fails, it attempts to decode using the URL base64 encoding scheme.


**Signature**
```
Decode(in String) []Byte
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`in`  | [`String`][String] | The base64 encoded string to decode |


**Return**

| Type | Description | 
|------|-------------|
| [`[]Byte`][Byte]  | The decoded byte array               |



!!! example

    ```go
	{{ $encoded := "SGVsbG8sIFdvcmxkIQ==" }}
    {{ $decoded, $err := base64.Decode $encoded }}
    The decoded byte array is {{ $decoded }}
    ```
    <div class="result" sh>
    <pre>
    The decoded byte array is Hello, World!
    </pre>
    </div>


    In this example, the `Decode` method is utilized within the template to convert the base64 encoded string `"SGVsbG8sIFdvcmxkIQ=="` back to its original byte array representation, resulting in the output `The decoded byte array is Hello, World!`.

## JSON





### json.ToJson

**Description**

The `ToJson` method in the `json` space converts a Go data structure into its JSON string representation. This method uses the standard JSON encoding scheme to marshal the input data into a JSON string.


**Signature**
```
ToJson(data Object) String
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
| `data` | [`Object`][Object] | The Go data structure to convert to JSON |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String]  | The JSON string representation of the data|



!!! example

    ```go
    {{ $data := dict "name" "John" "age" 30 }}
    {{ $jsonStr, $err := json.ToJson $data }}
    The JSON representation is {{ $jsonStr }}
    ```
    <div class="result" sh>
    <pre>
    The JSON representation is {"name":"John","age":30}
    </pre>
    </div>

    In this example, the `ToJson` method is utilized within the template to convert the dictionary `{"name": "John", "age": 30}` into its JSON string representation, resulting in the output `The JSON representation is {"name":"John","age":30}`.



### json.PrettifyJSON

**Description**

The `PrettifyJSON` method in the `json` space takes a JSON string and formats it into a human-readable, pretty-printed JSON string with indentation. This method first unmarshals the input JSON string into an intermediate data structure and then marshals it back into a pretty-printed JSON string.


**Signature**
```
PrettifyJSON(jsonString String) string
```

**Parameters**

| Name | Type | Description | 
|------|------|-------------|
|`jsonString` |   | The JSON string to prettify        |


**Return**

| Type | Description | 
|------|-------------|
| [`String`][String]  | The pretty-printed JSON string            |



!!! example

    ```go
    {{ $jsonStr := "{\"name\":\"John\",\"age\":30}" }}
    {{ $prettyJsonStr, $err := json.PrettifyJSON $jsonStr }}
    The pretty-printed JSON is {{ $prettyJsonStr }}
    ```
    <div class="result" sh>
    <pre>
    The pretty-printed JSON is {
    "name": "John",
    "age": 30
    }
    </pre>
    </div>


    In this example, the `PrettifyJSON` method is utilized within the template to convert the JSON string `{"name":"John","age":30}` into a pretty-printed JSON string, resulting in the output `The pretty-printed JSON is {
    "name": "John",
    "age": 30
    }`.


<!-- Additional links -->
[Object]: ../../references/value-types.md#object
[Number]: ../../references/value-types.md#number
[Byte]: ../../references/value-types.md#int8-byte
[Int]: ../../references/value-types.md#int32-int
[Int64]: ../../references/value-types.md#int64-long
[Float64]: ../../references/value-types.md#float64-double
[Text]: ../../references/value-types.md#text
[String]: ../../references/value-types.md#string
[Boolean]: ../../references/value-types.md#boolean
[Context]: context.md