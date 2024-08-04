---
title: Code Template Concept
tags:
    - template
    - code
---

# Code Template



A **Code Template** provides specialized context and functions optimized for generating code. It utilizes the "Code Template Context".

## Key Features of an Code Template

- **Optimized for Code Generation**: Provides specialized context and functions for writing code efficiently.
- **Code Template Context**: Utilizes the "Code Template Context" to streamline the code generation process.
- **Automation**: Simplifies the creation of repetitive code patterns, enhancing developer productivity.

## Code Template Object Model

Templates can be defined and managed using YAML configuration files. A typical application project configuration in YAML might look like this:

```yaml
Type: Template
Kind: Code
Name: ResponseDto
Metadata:
Tags:
Specifications:
  Name: ResponseDto
  Output: '{{.Resource.Name}}.cs'
  Set: EShopping
  Layers:
  - Dtos
  Sections:
      Classes:
      - ResponseDto
  Template:
      Code: |
      // This is a code template for ResponseDto
      public class {{.name}} {
          public string Name { get; set; }
          public string Description { get; set; }
      }
```

For more detailed information on the Code Template Object Model, refer to the [Code Template Object Model][code_template_object_model].



<!-- Additional links -->

[code_template_object_model]: ../../guides/schemas/object/template/code-template-object-model.md